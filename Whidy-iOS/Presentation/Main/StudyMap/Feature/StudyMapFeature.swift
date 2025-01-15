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

    }
    
    enum Action : BindableAction {
        case binding(BindingAction<State>)
        case networkResponse(NetworkReponse)
        case buttonTapped(ButtonTapped)
        case viewTransition(ViewTransition)
        case anyAction(AnyAction)
    }
    
    enum NetworkReponse {
        
    }
    
    enum ButtonTapped {
        
    }
    
    enum ViewTransition {
        case onAppear
    }

    enum AnyAction {

    }
    
    @Dependency(\.networkManager) var networkManager
    
    var body : some ReducerOf<Self> {
        
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            
                
            default :
                break
            }
            return .none
        }
    }
}

