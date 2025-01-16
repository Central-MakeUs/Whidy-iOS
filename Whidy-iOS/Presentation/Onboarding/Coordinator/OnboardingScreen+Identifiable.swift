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
        case .web:
                .web
        }
    }
    
    enum ID : Identifiable {
        case auth
        case web
        
        var id : ID { self }
    }
}
