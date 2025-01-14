//
//  EmptyResponse.swift
//  z-car
//
//  Created by Namuplanet on 9/9/24.
//

import Foundation

struct EmptyResponseModel: Decodable {
    var code: String? = ""
    var message: String? = ""
    var isHttpStatusOkCode: Bool {
        guard let code = code, let statusCode = Int(code) else {
            return false
        }
        return RemoteConstants.httpStatusValidRange.contains(statusCode)
    }
}
