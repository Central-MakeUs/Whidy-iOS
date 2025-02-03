//
//  InfoFeature.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 2/3/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct InfoFeautre {
    @ObservableState
    struct State : Equatable {
        let id = UUID()
        var currentPlace : Place = .init()
    }
    
    enum Action : BindableAction {
        case binding(BindingAction<State>)
        case networkResponse(NetworkReponse)
        case buttonTapped(ButtonTapped)
        case viewTransition(ViewTransition)
        case anyAction(AnyAction)
    }
    
    enum ViewTransition {
        case onAppear
    }
    
    enum NetworkReponse {
        
    }
    
    enum ButtonTapped {
        
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


