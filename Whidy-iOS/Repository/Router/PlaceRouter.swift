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
    case placeGeneralCafe(id : Int)
    case placeStudyCafe(id : Int)
    case placeFreeStudy(id : Int)
    case placeFranchise(id : Int)
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
        case let .placeGeneralCafe(id):
            return "/api/place/general-cafe/\(id)"
        case let .placeStudyCafe(id):
            return "/api/place/study-cafe/\(id)"
        case let .placeFreeStudy(id):
            return "/api/place/free-study/\(id)"
        case let .placeFranchise(id):
            return "/api/place/franchise-cafe/\(id)"
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
}
