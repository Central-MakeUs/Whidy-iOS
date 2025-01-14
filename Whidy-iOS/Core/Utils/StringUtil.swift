//
//  StringUtil.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 9/16/24.
//

import Foundation

class StringUtil {
    static func optionalToString(_ optional: Any?) -> String {
        if let value = optional {
            return String(describing: value)
        } else {
            return ""
        }
    }
}
