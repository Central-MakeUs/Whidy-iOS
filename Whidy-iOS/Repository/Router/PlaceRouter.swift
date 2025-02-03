//
//  PlaceRouter.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 2/2/25.
//

import Foundation
import Alamofire

enum PlaceRouter {
    case place(condition : PlaceSearchCondition)
}

extension PlaceRouter : TargetType {
    var baseURL: URL {
        switch self {
        default:
            return url()
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .place:
            return "api/place"
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
        case let .place(condition):
            return [
                "centerLatitude": condition.centerLatitude,
                "centerLongitude": condition.centerLongitude,
                "radius" : condition.radius,
                "placeType" : condition.placeType.joined(separator: ","),
                "keyword" : condition.keyword
            ]
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
}
