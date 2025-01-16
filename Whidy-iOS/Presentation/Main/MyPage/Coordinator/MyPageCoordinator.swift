//
//  MyPageCoordinator.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/15/25.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators

struct MyPageCoordinatorView : View {
    let store : StoreOf<MyPageCoordinator>
    
    var body: some View {
        TCARouter(store.scope(state: \.routes, action: \.router)) { screen in
            switch screen.case {
            case let .myPage(store):
                MyPageView(store: store)
            }
        }
    }
}

@Reducer
struct MyPageCoordinator {
    @ObservableState
    struct State : Equatable {
        static var initialState = State(routes: [.root(.myPage(.init()), embedInNavigationView: true)])
        var routes: IdentifiedArrayOf<Route<MyPageScreen.State>>
    }
    
    enum Action {
        case router(IdentifiedRouterActionOf<MyPageScreen>)
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
