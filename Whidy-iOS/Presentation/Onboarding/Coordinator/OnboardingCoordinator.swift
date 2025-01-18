//
//  OnboardingCoordinator.swift
//  Whidy-iOS
//
//  Created by Namuplanet on 1/14/25.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators

//MARK: - CoordinatorView
struct OnboardingCoordinatorView : View {
    @Perception.Bindable var store : StoreOf<OnboardingCoordinator>
    
    var body: some View {
        TCARouter(store.scope(state: \.routes, action: \.router)) { screen in
            switch screen.case {
            case let .auth(store):
                AuthView(store: store)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            case let .memberNickname(store):
                MemberNicknameView(store: store)
            case let .memberEmail(store):
                MemberEmailView(store: store)
            case let .web(store):
                WebView(store: store)
            }
        }
        .accentColor(Color(hex: ColorSystem.black.rawValue))
        .onAppear {
//            store.send(.onAppear)
        }
        .onOpenURL { url in
            Logger.debug("Redirect Url : \(url), isDeepLink : \(url.isDeepLink), url.deeplinkComponent : \(String(describing: url.queryParameters)), host : \(url.pageIdentifier) 🐼🐼🐼🐼🐼🐼🐼🐼🐼")
            
            if url.isDeepLink {
                store.send(.deepLink(.handler(url.pageIdentifier)))
            }
        }
    }
}

//MARK: - Coordinator
@Reducer
struct OnboardingCoordinator {
    @ObservableState
    struct State : Equatable {
        static var initialState = State(routes: [.root(.auth(.init()), embedInNavigationView: true)])
        var routes : IdentifiedArrayOf<Route<OnbaordingScreen.State>>
        
        @Shared(Environment.SharedInMemoryType.memberSession.keys) var memberSession : MemberSession = .init()
        
        //TODO: - Struct 변환
        var nickname : String = .init()
        var email : String = .init()
        var signUpCd : String?
        ///
    }
    
    enum Action {
        case router(IdentifiedRouterActionOf<OnbaordingScreen>)
        case deepLink(DeepLink)
        case networkResponse(NetworkReponse)
        case anyAction(AnyAction)
    }
    
    enum DeepLink {
        case handler(DeepLinkPath)
    }
    
    enum NetworkReponse {
        case signUp(Result<SignIn, APIError>)
    }
    
    enum AnyAction {
        case login(AuthToken)
    }
    
    @Dependency(\.networkManager) var networkManager
    
    var body : some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case let .router(.routeAction(id: .auth, action: .auth(.viewTransition(.redirectView(url))))):
                
                state.routes.presentSheet(.web(.init(url: url)))
                
            case .router(.routeAction(id: .web, action: .web(.dismiss))):
                state.routes.dismiss()
                
            case .router(.routeAction(id: .memberEmail, action: .memberEmail(.viewTransition(.goToBack)))):
                state.routes.goBack()
                
            /// Onboarding Member 정보 입력
            case let .router(.routeAction(id: .memberNickname, action: .memberNickname(.viewTransition(.goToEmail(nickname))))):
                state.nickname = nickname
                state.routes.push(.memberEmail(.init()))
                
            /// 회원가입
            case let .router(.routeAction(id: .memberEmail, action: .memberEmail(.viewTransition(.goToHome(email))))):
                state.email = email
                
                guard let signUpCd = state.signUpCd else { return .none }
                let signUpRequest = SignUpRequest(signUpCode: signUpCd, email: state.email, name: state.nickname)
                
                return .run { send in
                    await send(.networkResponse(.signUp(
                        networkManager.signUp(request: signUpRequest)
                    )))
                }
                
            // 로그인
            case let .anyAction(.login(authToken)):
                Logger.debug("authToken - \(authToken)")
                state.$memberSession.withLock {
                    $0.setLoggedIn(true)
                    $0.setAccessToken(authToken.accessToken)
                    $0.setRefreshToken(authToken.refreshToken)
                }
                
            //TODO: - 가입 성공시 화면전환 로직, 로그인 성공시 화면전환 로직
            case let .networkResponse(.signUp(.success(signIn))):
                Logger.debug("SignUp Success - \(signIn) 🐼🐼🐼🐼🐼🐼🐼🐼🐼🐼🐼")
                state.$memberSession.withLock {
                    $0.setLoggedIn(true)
                    $0.setAccessToken(signIn.authToken.accessToken)
                    $0.setRefreshToken(signIn.authToken.refreshToken)
                    $0.setUserId(signIn.userId)
                }
                
            case let .networkResponse(.signUp(.failure(error))):
                let errorType = APIError.networkErrorType(error: error)
                Logger.error("\(error) ->>🤔 \(errorType)")
                
            case let .deepLink(.handler(path)):
                switch path {
                case .home:
                    Logger.debug("Home으로 이동, parameter : \(String(describing: path.parameter))")
                                        
                    guard let authToken = path.parameter, let accessToken = authToken["accessToken"], let refreshToken = authToken["refreshToken"] else { return .none }
                    
                    state.routes.dismissAll()
                    
                    return .run { send in
                        //TODO: - LoadingView 필요함
                        try await Task.sleep(for: .seconds(0.5))
                        await send(.anyAction(.login(AuthToken(accessToken: accessToken, refreshToken: refreshToken))))
                    }
                    
                case .signup:
                    Logger.debug("signup으로 이동,  parameter : \(String(describing: path.parameter))")
                    state.signUpCd = path.parameter?["signUpCode"]
                    
                    return .routeWithDelaysIfUnsupported(state.routes, action: \.router) {
                        $0.dismissAll()
                        $0.push(.memberNickname(.init()))
                    }
                    
                default:
                    break
                }
                
            default:
                break
            }
            return .none
        }
        .forEachRoute(\.routes, action: \.router)
    }
}
