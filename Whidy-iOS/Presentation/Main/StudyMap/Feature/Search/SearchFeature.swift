//
//  SearchFeature.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/29/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct SearchFeature {
    @ObservableState
    struct State : Equatable {
        let id = UUID()
        var userInput : String = .init()
        var isHideLatestSearch : Bool = false
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
        case goToBack
    }
    
    enum NetworkReponse {
        
    }
    
    enum ButtonTapped {
        case removeLatestSearch
    }
  

    enum AnyAction {

    }
    
    @Dependency(\.networkManager) var networkManager
    
    var body : some ReducerOf<Self> {
        
        BindingReducer()

        buttonTappedReducer()
        bindingReducer()
    }
}

extension SearchFeature {
    func buttonTappedReducer() -> some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            
            case .buttonTapped(.removeLatestSearch):
                LatestSearch.delRowAll()
                
            default:
                break
            }
            
            return .none
        }
    }
    
    func bindingReducer() -> some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .binding(\.userInput):
                if !state.userInput.isEmpty {
                    state.isHideLatestSearch = true
                } else {
                    state.isHideLatestSearch = false
                }
                
            default:
                break
            }
            
            return .none
        }
    }
}
