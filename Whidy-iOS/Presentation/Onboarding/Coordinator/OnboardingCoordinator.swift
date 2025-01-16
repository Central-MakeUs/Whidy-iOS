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
            case let .member(store):
                MemberView(store: store)
            case let .web(store):
                WebView(store: store)
            }
        }
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
    }
    
    enum Action {
        case router(IdentifiedRouterActionOf<OnbaordingScreen>)
        case deepLink(DeepLink)
    }
    
    enum DeepLink {
        case handler(DeepLinkPath)
    }
    
    var body : some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case let .router(.routeAction(id: .auth, action: .auth(.viewTransition(.redirectView(url))))):
                
                state.routes.presentSheet(.web(.init(url: url)))
                
            case .router(.routeAction(id: .web, action: .web(.dismiss))):
                state.routes.dismiss()
                
            case let .deepLink(.handler(path)):
                switch path {
                case .home:
                    Logger.debug("Home으로 이동, parameter : \(String(describing: path.parameter))")
                case .signup:
                    Logger.debug("signup으로 이동,  parameter : \(String(describing: path.parameter))")
                    let signUpCd : String? = path.parameter?["signUpCode"]
                    
                    return .routeWithDelaysIfUnsupported(state.routes, action: \.router) {
                        $0.dismissAll()
                        $0.push(.member(.init(signUpCd: signUpCd.unwrap())))
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
