//
//  StudyMapFeature.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/15/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct StudyMapFeature {
    @ObservableState
    struct State : Equatable {
        let id = UUID()
        var filterCase : [MapFilterCase] =  MapFilterCase.getAllFilters()
    }
    
    enum Action : BindableAction {
        case binding(BindingAction<State>)
        case viewTransition(ViewTransition)
        case networkResponse(NetworkReponse)
        case buttonTapped(ButtonTapped)
        case anyAction(AnyAction)
    }
    
    enum ViewTransition {
        case onAppear
        case goToSearch
    }
    
    enum NetworkReponse {
        
    }
    
    enum ButtonTapped {
        case search
    }

    enum AnyAction {

    }
    
    @Dependency(\.networkManager) var networkManager
    
    var body : some ReducerOf<Self> {
        
        BindingReducer()
        
        buttonTappedReducer()
    }
}

extension StudyMapFeature {
    func buttonTappedReducer() -> some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .buttonTapped(.search):
                return .run { send in
                    await send(.viewTransition(.goToSearch))
                }
            default:
                break
            }
            
            return .none
        }
    }
}
