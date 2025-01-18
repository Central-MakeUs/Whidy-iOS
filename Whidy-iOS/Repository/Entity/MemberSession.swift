//
//  MemberSession.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/18/25.
//

import Foundation
import SwiftyUserDefaults

struct MemberSession : Equatable {
    var isLoggedIn : Bool = false
    var accessToken : String = .init()
    var refreshToken : String = .init()
    var userId : Int64 = .init()
    
    mutating func setAccessToken(_ accessToken: String) {
        self.accessToken = accessToken
    }
    
    mutating func setRefreshToken(_ refreshToken: String) {
        self.refreshToken = refreshToken
    }
    
    mutating func setLoggedIn(_ isLoggedIn: Bool) {
        self.isLoggedIn = isLoggedIn
    }
    
    mutating func setUserId(_ userId: Int64) {
        self.userId = userId
    }
}
