//
//  CommonRouter.swift
//  z-car
//
//  Created by Namuplanet on 8/26/24.
//

import Foundation
import Alamofire

enum CommonRouter {
    case appVersion
}

extension CommonRouter : TargetType {
    var baseURL: URL {
        return url()
    }
    
    var method: HTTPMethod {
        switch self {
        case .appVersion:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .appVersion:
            return "/comm/app-version"
        }
    }
    
    var header: [String : String] {
        switch self {
        case .appVersion:
            return adpat()
        }
    }
    
    var parameter: Parameters? {
        switch self {
        default :
            return nil
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        default :
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        default :
            return nil
        }
    }
    
    
}
