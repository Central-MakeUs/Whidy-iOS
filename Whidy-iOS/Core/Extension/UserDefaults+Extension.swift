//
//  UserDefaults+Extension.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 8/27/24.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    enum UserDefaultsKeys : String {
        // Auto Login
        case autoLogin
        case accessToken
        case refreshToken
    }
    
    var autoLogin: DefaultsKey<Bool> { .init(UserDefaultsKeys.autoLogin.rawValue, defaultValue: false) }
    var accessToken: DefaultsKey<String> { .init(UserDefaultsKeys.accessToken.rawValue, defaultValue: "") }
    var refreshToken: DefaultsKey<String> { .init(UserDefaultsKeys.refreshToken.rawValue, defaultValue: "") }
}
