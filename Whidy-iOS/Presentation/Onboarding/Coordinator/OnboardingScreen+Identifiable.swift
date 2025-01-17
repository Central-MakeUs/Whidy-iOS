//
//  OnboardingScreen+Identifiable.swift
//  Whidy-iOS
//
//  Created by Namuplanet on 1/14/25.
//

import Foundation

extension OnbaordingScreen.State : Identifiable {
    var id : ID {
        switch self {
        case .auth:
                .auth
        case .memberNickname:
                .memberNickname
        case .memberEmail:
                .memberEmail
        case .web:
                .web
        }
    }
    
    enum ID : Identifiable {
        case auth
        case memberNickname
        case memberEmail
        case web
        
        var id : ID { self }
    }
}
