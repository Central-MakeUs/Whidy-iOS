//
//  ScrapCoordinator.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/15/25.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators

struct ScrapCoordinatorView : View {
    let store : StoreOf<ScrapCoordinator>
    
    var body: some View {
        TCARouter(store.scope(state: \.routes, action: \.router)) { screen in
            switch screen.case {
            case let .scrap(store):
                ScrapView(store: store)
            }
        }
    }
}

@Reducer
struct ScrapCoordinator {
    @ObservableState
    struct State : Equatable {
        static var initialState = State(routes: [.root(.scrap(.init()), embedInNavigationView: true)])
        var routes: IdentifiedArrayOf<Route<ScrapScreen.State>>
    }
    
    enum Action {
        case router(IdentifiedRouterActionOf<ScrapScreen>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
                
            default :
                break
            }
            return .none
        }
        .forEachRoute(\.routes, action: \.router)
    }
}
