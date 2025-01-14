//
//  CommonRouter.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 8/26/24.
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
    
    
    /*
     // multipart 예시
     var multipart: MultipartFormData {
         switch self {
         case let .consumableReceipt(request):
             let multiPart = MultipartFormData()
             multiPart.append(request.recipeImage, withName: "receiptImg", fileName: "image_\(Date().timeIntervalSince1970)", mimeType: RemoteConstants.MimeType.imageToJpeg.value)
             multiPart.append(request.vin.data(using: String.Encoding.utf8)!, withName: "vin", fileName: nil, mimeType: RemoteConstants.MimeType.text.value)
             multiPart.append(request.cnsumabId.data(using: String.Encoding.utf8)!, withName: "cnsumabId", fileName: nil, mimeType: RemoteConstants.MimeType.text.value)

             
             return multiPart
             
         default:
             return MultipartFormData()
         }
     }
     var multipart: MultipartFormData {
         switch self {
         case let .updateProfileImage(request):
             let multiPart = MultipartFormData()
             multiPart.append(request.image, withName: "mbrProfileImg", fileName: "profileImg", mimeType: RemoteConstants.MimeType.imageToJpeg.value)
             
             return multiPart

         default :
             return MultipartFormData()
         }
     }
     
     //post
     var body: Data? {
         switch self {
         case let .carisyou(carisyou):
             let encoder = JSONEncoder()
             return try? encoder.encode(carisyou)
         case let .carRegister(carRegister):
             let encoder = JSONEncoder()
             return try? encoder.encode(carRegister)
         case let .carModify(carModify):
             let encoder = JSONEncoder()
             return try? encoder.encode(carModify)
         case let .indivCarCheck(carIndv):
             let encoder = JSONEncoder()
             return try? encoder.encode(carIndv)
         default :
             return nil
         }
     }
    */

    
}
