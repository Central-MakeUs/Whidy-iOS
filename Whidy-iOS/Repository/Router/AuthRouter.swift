//
//  AuthRouter.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 8/26/24.
//

import Foundation
import Alamofire

enum AuthRouter {
    case redirect(OAuthType)
    case callbackGet(oAuthType:OAuthType, code : String)
    case callbackPost(oAuthType:OAuthType, code : String)
    case signUp
    case signOut
    case refresh
}

extension AuthRouter : TargetType {
    var baseURL: URL {
        switch self {
        default:
            return url()
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .callbackGet, .redirect:
            return .get
        default:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case let .callbackGet(oAuth,_), let .callbackPost(oAuth,_):
            return "auth/callback/\(oAuth.type)"
        case .signUp:
            return "auth/sign-up"
        case .signOut:
            return "auth/sign-out"
        case .refresh:
            return "auth/refresh-token"
        case let .redirect(oAuth):
            return "auth/\(oAuth.type)"
        }
    }
    
    var header: [String : String] {
        switch self {
        default:
            return adpat()
        }
    }
    
    var parameter: Parameters? {
        switch self {
        case let .callbackGet(_, code), let .callbackPost(_, code):
            return ["code": code]
        default:
            return nil
        }
    }

    var queryItems: [URLQueryItem]? {
        return nil
    }

    var body: Data? {
        switch self {
        default:
            return nil
        }
    }
    
    var fullUrl: URL? {
        switch self {
        case .redirect:
            return URL(string: "\(baseURL)/\(path)")
        default:
            return nil
        }
    }
}
