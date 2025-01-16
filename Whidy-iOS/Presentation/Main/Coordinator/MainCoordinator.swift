//
//  MainCoordinator.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/15/25.
//

import Foundation
import ComposableArchitecture
import TCACoordinators

@Reducer
struct MainCoordinator {
    @ObservableState
    struct State : Equatable {
        static let initialState = State(
            studyMap: .initialState,
            scrap: .initialState,
            myPage: .initialState,
            selectedTab: .studyMap
        )
        
        var studyMap : StudyMapCoordinator.State
        var scrap : ScrapCoordinator.State
        var myPage : MyPageCoordinator.State
        var selectedTab : Tab
    }
    
    enum Action : BindableAction {
        case binding(BindingAction<State>)
        case tabSelected(Tab)
        case studyMap(StudyMapCoordinator.Action)
        case scrap(ScrapCoordinator.Action)
        case myPage(MyPageCoordinator.Action)
        case networkResponse(NetworkReponse)
        case viewTransition(ViewTransition)
        case anyAction(AnyAction)
    }
    
    enum Tab : Hashable {
        case studyMap
        case scrap
        case myPage
    }
    
    enum NetworkReponse {

    }
    
    enum ViewTransition {

    }
    
    enum AnyAction {
        
    }
    
    @Dependency(\.networkManager) var networkManager
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Scope(state: \.studyMap, action: \.studyMap) {
            StudyMapCoordinator()
        }
        
        Scope(state: \.scrap, action: \.scrap) {
            ScrapCoordinator()
        }
        
        Scope(state: \.myPage, action: \.myPage) {
            MyPageCoordinator()
        }
        
        tabSelectedReducer()
//        viewTransitionReducer()
//        childActionReducer()
//        networkResponseReducer()
//        anyActionReducer()
    }
}
