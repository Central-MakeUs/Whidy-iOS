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
    
    var value : String {
        switch self {
        case .accept:
            return "*/*"
        case .contentType:
            return "application/json"
        default :
            return ""
        }
    }
}
