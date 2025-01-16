//
//  OAuthType.swift
//  Whidy-iOS
//
//  Created by Namuplanet on 1/14/25.
//

import Foundation

enum OAuthType {
    case apple
    case kakao
    case none
    
    var type : String {
        switch self {
        case .apple:
            return "APPLE"
        case .kakao:
            return "KAKAO"
        case .none:
            return "NONE"
        }
    }
}
