//
//  HTTPHeader.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 8/26/24.
//

import Foundation
import UIKit

enum HTTPHeader : String {
    case authorization = "Authorization"
    case accept = "Accept"
    case contentType = "Content-Type"
    case deviceName = "deviceNm"
    case osKind = "osKind"
    case version = "version"
    case serviceKind = "serviceKind"
    case appKind = "appKind"
    case appTypeCd = "appTypeCd"
    
    var value : String {
        switch self {
        case .accept:
            return "*/*"
        case .contentType:
            return "application/json"
        case .deviceName:
            return "iPhone"
        case .osKind:
            return "04"
        case .version:
            return Environment.appVersion
        case .serviceKind:
            return "01"
        case .appKind:
            return "02"
        case .appTypeCd:
            return "01"
        default :
            return ""
        }
    }
    

}
