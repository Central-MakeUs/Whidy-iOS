//
//  NetworkManager+Auth.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 8/26/24.
//

import Foundation
import Alamofire

extension NetworkManager {
    func getAuth(authType : OAuthType) -> URL {
        return AuthRouter.redirect(authType).fullUrl!
    }
    
    func signUp(request : SignUpRequest) async -> Result<SignIn, APIError> {
        do {
            let response = try await requestAPI(router: AuthRouter.signUp(request: request), of: SignInResponse.self)
            return .success(response.toDomain())
        } catch {
            if let apiError = error as? APIError {
                return .failure(apiError)
            } else {
                return .failure(APIError.unknown)
            }
        }
    }
    
    func refresh() async -> Result<AuthToken, APIError> {
        do {
            let response = try await requestAPI(router: AuthRouter.refresh, of: AuthToken.self)
            return .success(response)
        } catch {
            if let apiError = error as? APIError {
                return .failure(apiError)
            } else {
                return .failure(APIError.unknown)
            }
        }
    }
}
