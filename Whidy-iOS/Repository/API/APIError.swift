//
//  APIError.swift
//  Teams
//
//  Created by JinwooLee on 6/10/24.
//

import Foundation

enum APIError : Error, Equatable, LocalizedError {
    case network(errorCode: String, message: String)
    case decodingError
    case unknown
    
    var errorDescription: String {
        switch self {
        case let .network(errorCode, _):
            return errorCode
        case .decodingError:
            return "디코딩 에러"
        case .unknown:
            return "내부 서버 오류"
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
        case unknown
        
        var errorMessage: String {
            switch self {
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

        default:
            return .unknown
        }
    }
}
