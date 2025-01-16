//
//  URL+Extension.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/16/25.
//

import Foundation

enum DeepLinkPath : Hashable {
    case signup([String: String]?)
    case home([String: String]?)
    case none
    
    var parameter : [String: String]? {
        switch self {
        case let .signup(parm), let .home(parm):
            return parm
        case .none:
            return nil
        }
    }
}

extension URL {
    var isDeepLink : Bool {
        return scheme == "whidy"
    }
    
    var pageIdentifier : DeepLinkPath {
        guard isDeepLink else { return .none }
        switch host {
        case "sign-up":
            return .signup(queryParameters)
        case "home":
            return .home(queryParameters)
        default:
            return .none
        }
    }
    
    var queryParameters: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems else {
            return nil
        }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }
}
