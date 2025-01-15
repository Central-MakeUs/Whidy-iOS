//
//  RootCoordinator.swift
//  Whidy-iOS
//
//  Created by Namuplanet on 1/14/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct RootCoordinator {
    @ObservableState
    struct State: Equatable {
        static let initialState = State(
            onboarding: .initialState, main: .initialState)
        var onboarding : OnboardingCoordinator.State
        var main : MainCoordinator.State
        var isLoggined : Bool = true
    }
    
    enum Action : BindableAction {
        case binding(BindingAction<State>)
        case onboarding(OnboardingCoordinator.Action)
        case main(MainCoordinator.Action)
        case viewTransition(ViewTransition)
        case networkResponse(NetworkReponse)
        case anyAction(AnyAction)
    }
    
    enum ViewTransition {
        case onAppear
        case DisAppear
    }
    
    enum NetworkReponse {
        case appVersionCheck(String?)
    }
    
    enum AnyAction {
        case doAppVersionCheck
    }
    
    var body : some ReducerOf<Self> {
        BindingReducer()
        
        Scope(state: \.onboarding, action: \.onboarding) {
            OnboardingCoordinator()
        }
        
        Scope(state: \.main, action: \.main) {
            MainCoordinator()
        }
    }
}
