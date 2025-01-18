//
//  APIError.swift
//  Teams
//
//  Created by JinwooLee on 6/10/24.
//

import Foundation

enum APIError : Error, Equatable, LocalizedError {
    case network(errorCode: Int, message: String)
    case decodingError
    case unknown
    
    var errorDescription: Int {
        switch self {
        case let .network(errorCode, _):
            return errorCode
        case .decodingError:
            return 0
        case .unknown:
            return -1
        }
    }
    
    var errorMessage : String {
        switch self {
        case let .network(_, message):
            return message
        default :
            return ""
        }
    }
        
    enum ErrorType {
        case signUpDuplicate(message:String)
        case unknown
        
        var errorMessage: String {
            switch self {
            case let .signUpDuplicate(message):
                return message
            default:
                return ""
            }
        }
    }
    
    init(error : ErrorResponse) {
        self = .network(errorCode: error.code, message: error.message)
    }
    
    static func networkErrorType(error : APIError) -> ErrorType {
        switch error.errorDescription {
        case 409:
            return .signUpDuplicate(message: error.errorMessage)
        default:
            return .unknown
        }
    }
}
