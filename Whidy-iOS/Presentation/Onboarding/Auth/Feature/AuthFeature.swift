//
//  AuthFeature.swift
//  Whidy-iOS
//
//  Created by Namuplanet on 1/14/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AuthFeature {
    @ObservableState
    struct State : Equatable {
        let id = UUID()
        var oAuthType : OAuthType = .none
    }
    
    enum Action {
        case viewTransition(ViewTransition)
        case buttonTapped(ButtonTapped)
    }
    
    enum ViewTransition {
        case onAppear
        case onDisappear
        case redirectView(URL)
    }
    
    enum ButtonTapped {
        case kakaoLogin
        case appleLogin
    }
    
    @Dependency(\.networkManager) var networkManager
    
    var body : some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .viewTransition(.onAppear):
                Logger.info("AuthView - OnAppear")
                                
            case .buttonTapped(.kakaoLogin):
                Logger.debug("KakaoLogin Button Tapped")
                
                return .run { send in
                    await send(.viewTransition(.redirectView(networkManager.getAuth(authType: .kakao))))
                }
                
            case .buttonTapped(.appleLogin):
                Logger.debug("AppleLogin Button Tapped")
                return .run { send in
                    await send(.viewTransition(.redirectView(networkManager.getAuth(authType: .apple))))
                }
                
            default:
                return .none
            }
            
            return .none
        }
        
    }
}
