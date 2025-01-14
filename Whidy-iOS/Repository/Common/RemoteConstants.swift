//
//  RemoteConstants.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 2/10/24.
//

import Foundation
import SwiftyUserDefaults

public enum APIVersion: String {
    case v2 = "/v2"
}
       
class RemoteConstants {
    static var apiHost: String {
        return ""
    }
    
    static var currentAPIVersion : String {
        return APIVersion.v2.rawValue
    }
    
    static let httpStatusValidRange = Array(200..<300)
    
    enum MimeType: String {
        case imageToJpeg = "image/jpeg"
        case pdf = "application/pdf"
        case text = ""
        
        var value: String {
            self.rawValue
        }
    }
}
