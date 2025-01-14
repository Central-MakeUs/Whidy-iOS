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
    }
    
    enum Action {
        case viewTransition(ViewTransition)
        case buttonTapped(ButtonTapped)
    }
    
    enum ViewTransition {
        case onAppear
        case onDisappear
    }
    
    enum ButtonTapped {
        
    }
}
