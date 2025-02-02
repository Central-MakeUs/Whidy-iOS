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
            case let .search(store):
                SearchView(store: store)
            case let .infoDetail(store):
                InfoDetailView(store: store)
            case let .reviewExpanded(store):
                ReviewExpandedView(store: store)
            case let .reviewWriteFilter(store):
                ReviewWriteFilterView(store: store)
            case let .reviewWriteText(store):
                ReviewWriteTextView(store: store)
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
    
    @Dependency(\.naverMapManager) var naverMapManager
    
    var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
                
            case .router(.routeAction(id: .studyMap, action: .studyMap(.viewTransition(.goToSearch)))):
                state.routes.push(.search(.init()))
                
            case .router(.routeAction(id: .studyMap, action: .studyMap(.viewTransition(.goToInfoDetail)))):
                state.routes.presentCover(.infoDetail(.init()))
            
            case .router(.routeAction(id: .search, action: .search(.viewTransition(.goToBack)))):
                state.routes.goBackTo(id: .studyMap)
                
            case .router(.routeAction(id: .studyMap, action: .studyMap(.viewTransition(.returnToSearch)))):
                state.routes.push(.search(.init()))
                
            case .router(.routeAction(id: .infoDetail, action: .infoDetail(.viewTransition(.dismiss)))):
                state.routes.goBackTo(id: .studyMap)
                
            case let .router(.routeAction(id: .search, action: .search(.viewTransition(.goToResultLocation(location))))):
                state.routes.goBackTo(id: .studyMap)
                naverMapManager.moveToSpecificLocation(location: location)
                
            default :
                break
            }
            return .none
        }
        .forEachRoute(\.routes, action: \.router)
    }
}
