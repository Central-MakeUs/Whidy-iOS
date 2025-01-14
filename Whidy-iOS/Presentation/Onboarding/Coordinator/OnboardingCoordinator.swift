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
            }
        }
        .onAppear {
//            store.send(.onAppear)
        }
    }
}

//MARK: - Coordinator
@Reducer
struct OnboardingCoordinator {
    @ObservableState
    struct State : Equatable {
        static var initialState = State(routes: [.root(.auth(.init()), embedInNavigationView: true)])
        var routes : [Route<OnbaordingScreen.State>]
    }
    
    enum Action {
        case router(IndexedRouterActionOf<OnbaordingScreen>)
    }
    
    var body : some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            default:
                break
            }
            return .none
        }
        .forEachRoute(\.routes, action: \.router)
    }
}
