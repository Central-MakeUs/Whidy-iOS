//
//  AuthRouter.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 8/26/24.
//

import Foundation
import Alamofire

enum AuthRouter {
    case autoLogin
    case socialLogin(request : SocialLoginRequest)
    case nIDAgreementCheck(request : NaverGetNidAgreementRequest)
    case naverLoginGetInfo
}

extension AuthRouter : TargetType {
    var baseURL: URL {
        switch self {
        case .socialLogin, .nIDAgreementCheck, .autoLogin:
            return url()
        case .naverLoginGetInfo:
            return naverApiUrl()
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .socialLogin, .nIDAgreementCheck, .autoLogin:
            return .post
        case .naverLoginGetInfo:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .autoLogin:
            return "auth/login/auto"
        case .socialLogin:
            return "auth/login/social"
        case .naverLoginGetInfo:
            return "nid/me"
        case .nIDAgreementCheck:
            return "social/nid/agreement"
        }
    }
    
    var header: [String : String] {
        switch self {
        case .socialLogin, .nIDAgreementCheck, .autoLogin:
            return adpat()
        case .naverLoginGetInfo:
            return naverAuthAdpat()
        }
    }
    
    var parameter: Parameters? {
        return nil
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    var body: Data? {
        switch self {
        case let .socialLogin(socialLoginUserInfo):
            let encoder = JSONEncoder()
            return try? encoder.encode(socialLoginUserInfo)
        case let .nIDAgreementCheck(nidAgreement):
            let encoder = JSONEncoder()
            return try? encoder.encode(nidAgreement)
        default:
            return nil
        }
    }
    
    
}
