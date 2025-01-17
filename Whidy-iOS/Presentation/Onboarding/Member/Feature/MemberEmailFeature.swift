//
//  MemberEmailFeature.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/16/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct MemberEmailFeature {
    @ObservableState
    struct State : Equatable {
        let id = UUID()
        var email : String = .init()
        var isValid : Bool = false
    }
    
    enum Action : BindableAction {
        case binding(BindingAction<State>)
        case networkResponse(NetworkReponse)
        case buttonTapped(ButtonTapped)
        case viewTransition(ViewTransition)
        case anyAction(AnyAction)
    }
    
    enum NetworkReponse {
        case signUp
    }
    
    enum ButtonTapped {
        case complete
    }
    
    enum ViewTransition {
        case onAppear
        case goToBack
    }

    enum AnyAction {

    }
    
    @Dependency(\.networkManager) var networkManager
    
    var body : some ReducerOf<Self> {
        
        BindingReducer()
        
        bindingReducer()
        buttonTappedReducer()
    }
}

extension MemberEmailFeature {
    func bindingReducer() -> some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .binding(\.email):
                Logger.debug(state.email)
                state.isValid = isValidEmail(state.email)
                
            default:
                break
            }
            
            return .none
        }
    }
    
    func buttonTappedReducer() -> some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .buttonTapped(.complete):
                Logger.debug("완료버튼 탭")
                
            default:
                break
            }
            
            return .none
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let regex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: email)
    }
}
