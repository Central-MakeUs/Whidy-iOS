//
//  AuthInterceptor.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/29/25.
//

import Foundation
import Alamofire
import SwiftyUserDefaults

final class AuthInterceptor : RequestAdapter, RequestRetrier, RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        if !Defaults.accessToken.isEmpty {
            request.setValue("Bearer " + Defaults.accessToken, forHTTPHeaderField: "Authorization")
        }
        
        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
         guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
             completion(.doNotRetryWithError(error))
             return
         }

        Task {
            let response = await NetworkManager.shared.refresh()
            Logger.debug("AuthToken Refresh Success ✅✅✅ - \(response)")
            switch response {
            case let .success(token):
                Defaults.accessToken = token.accessToken
                Defaults.refreshToken = token.refreshToken
            case let .failure(error):
                completion(.doNotRetryWithError(error))
            }
        }
     }
}
