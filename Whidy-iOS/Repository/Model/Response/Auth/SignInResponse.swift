//
//  SignInResponse.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/17/25.
//

import Foundation

struct SignInResponse : Decodable {
    var authToken : AuthToken
    var userId : Int64
}

extension SignInResponse {
    func toDomain() -> SignIn {
        return .init(authToken: authToken, userId: userId)
    }
}

struct AuthToken : Decodable {
    var accessToken : String
    var refreshToken : String
}
