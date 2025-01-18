//
//  ErrorResponse.swift
//  z-car
//
//  Created by Namuplanet on 8/27/24.
//

import Foundation

struct ErrorResponse : Decodable {
    let code : Int
    let message : String
    let argumentMessages : String?
}
