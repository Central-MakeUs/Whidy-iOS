//
//  OnboardingCoordinator.swift
//  Whidy-iOS
//
//  Created by Namuplanet on 1/14/25.
//

import ComposableArchitecture
import TCACoordinators
import SwiftyUserDefaults

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
        
        var isSignUpError : Bool = false
        var errorMessage : String = .init()
    }
    
    enum Action : BindableAction {
        case router(IdentifiedRouterActionOf<OnbaordingScreen>)
        case binding(BindingAction<State>)
        case viewTransition(ViewTransition)
        case deepLink(DeepLink)
        case networkResponse(NetworkReponse)
        case anyAction(AnyAction)
    }
    
    enum ViewTransition {
        case onAppear
        case onDisappear
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
        
        BindingReducer()
        
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
                }
                
                Defaults.accessToken = authToken.accessToken
                Defaults.refreshToken = authToken.refreshToken
                
            //TODO: - 가입 성공시 화면전환 로직, 로그인 성공시 화면전환 로직
            case let .networkResponse(.signUp(.success(signIn))):
                Logger.debug("SignUp Success - \(signIn) 🐼🐼🐼🐼🐼🐼🐼🐼🐼🐼🐼")
                state.$memberSession.withLock {
                    $0.setLoggedIn(true)
                    $0.setUserId(signIn.userId)
                }
                
                Defaults.accessToken = signIn.authToken.accessToken
                Defaults.refreshToken = signIn.authToken.refreshToken
                
            case let .networkResponse(.signUp(.failure(error))):
                let errorType = APIError.networkErrorType(error: error)
                Logger.error("\(error) ->>🤔 \(errorType)")
                
                switch errorType {
                case .signUpDuplicate:
                    state.errorMessage = errorType.errorMessage
                    state.isSignUpError = true
                default:
                    return .none
                }
                
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
