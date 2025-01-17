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
                Logger.debug(state.nickname)
                
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
    
    func isValidNickname(_ nickname: String) -> Bool {
        // 조건 1: 닉네임은 2~12자의 길이
        guard nickname.count >= 2 && nickname.count <= 12 else {
            return false
        }
        
        // 조건 2: 닉네임은 알파벳, 숫자, 한글만 포함
        let regex = "^[a-zA-Z0-9가-힣]+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        guard predicate.evaluate(with: nickname) else {
            return false
        }
        
        // 조건 3: 닉네임이 금지어 목록에 포함되지 않음
        let forbiddenWords: [String] = ["admin", "root", "운영자"] // 원하는 금지어 추가
        guard !forbiddenWords.contains(where: { nickname.lowercased().contains($0.lowercased()) }) else {
            return false
        }
        
        return true
    }
}
