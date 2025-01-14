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
        }
    }
    
    enum ID : Identifiable {
        case auth
        
        var id : ID { self }
    }
}
