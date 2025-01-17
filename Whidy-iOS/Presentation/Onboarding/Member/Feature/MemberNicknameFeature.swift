//
//  MemberNicknameFeature.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/16/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct MemberNicknameFeature {
    @ObservableState
    struct State : Equatable {
        let id = UUID()
        var nickname : String = .init()
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
        case next
    }
    
    enum ViewTransition {
        case onAppear
        case goToEmail
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

extension MemberNicknameFeature {
    func bindingReducer() -> some ReducerOf<Self> {
        Reduce { state, action in
            switch action {           
            case .binding(\.nickname):
                state.isValid = isValidNickname(state.nickname)
                
            default:
                break
            }
            
            return .none
        }
    }
    
    func buttonTappedReducer() -> some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .buttonTapped(.next):
                Logger.debug("다음버튼 탭")
                return .run { send in
                    await send(.viewTransition(.goToEmail))
                }
                
            default:
                break
            }
            
            return .none
        }
    }
    
    private func isValidNickname(_ input: String) -> Bool {
        guard input.count <= 5 else { return false }
        let regex = "^[a-zA-Z가-힣ㄱ-ㅎㅏ-ㅣ]+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: input)
    }
}
