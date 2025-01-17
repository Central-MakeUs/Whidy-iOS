//
//  SignUpRequest.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/17/25.
//

import Foundation

struct SignUpRequest : Encodable {
    var signUpCode: String
    var email: String
    var name: String
}
