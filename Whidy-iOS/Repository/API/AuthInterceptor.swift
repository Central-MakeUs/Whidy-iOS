//
//  AuthInterceptor.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/29/25.
//

import Foundation
import Alamofire
import ComposableArchitecture

final class AuthInterceptor : RequestAdapter, RequestRetrier, RequestInterceptor {
    @Shared(Environment.SharedInMemoryType.memberSession.keys) var memberSession : MemberSession = .init()
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        if !memberSession.accessToken.isEmpty {
            request.setValue("Bearer " + memberSession.accessToken, forHTTPHeaderField: "Authorization")
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
            Logger.debug("AuthToken Refresh Success ✅✅✅")
            switch response {
            case let .success(token):
                $memberSession.withLock {
                    $0.setAccessToken(token.accessToken)
                    $0.setRefreshToken(token.refreshToken)
                }
            case let .failure(error):
                completion(.doNotRetryWithError(error))
            }
        }
     }
}
