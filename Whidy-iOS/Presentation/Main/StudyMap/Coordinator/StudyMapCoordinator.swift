//
//  StudyMapCoordinator.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/15/25.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators

struct StudyMapCoordinatorView : View {
    let store : StoreOf<StudyMapCoordinator>
    
    var body: some View {
        TCARouter(store.scope(state: \.routes, action: \.router)) { screen in
            switch screen.case {
            case let .studyMap(store):
                StudyMapView(store: store)
            }
        }
    }
}

@Reducer
struct StudyMapCoordinator {
    @ObservableState
    struct State : Equatable {
        static var initialState = State(routes: [.root(.studyMap(.init()), embedInNavigationView: true)])
        var routes: IdentifiedArrayOf<Route<StudyMapScreen.State>>
    }
    
    enum Action {
        case router(IdentifiedRouterActionOf<StudyMapScreen>)
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
