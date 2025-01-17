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
    }
    
//    func appVersion() async -> Result<AppVersionInfo, APIError> {
//        do {
//            let response = try await requestAPI(router: CommonRouter.appVersion, of: RemoteResponse<AppVersionResponse>.self)
//            return .success(response.contents.toDomain())
//        } catch {
//            if let apiError = error as? APIError {
//                return .failure(apiError)
//            } else {
//                //FIXME: - errorHandling 필요
//                return .failure(APIError.unknown)
//            }
//        }
//    }
//    
//    func getNaverAgreement(request : NaverGetNidAgreementRequest) async -> Result<NidAgreementList, APIError> {
//        do {
//            let response = try await requestAPI(router: AuthRouter.nIDAgreementCheck(request: request), of: RemoteResponse<[NidAgreementResponse]>.self)
//            return .success(response.contents.map({ $0.toDomain() }))
//        } catch {
//            if let apiError = error as? APIError {
//                return .failure(apiError)
//            } else {
//                return .failure(APIError.unknown)
//            }
//        }
//    }
//    
//    func updateConsumableRecipe(request:ConsumableRecipeRequest) async -> Result<Bool, APIError> {
//        let router = ConsumableRouter.consumableReceipt(request: request)
//        
//        do {
//            let response = try await requestAPI(router: router, of: RemoteResponse<Bool>.self, multipart: router.multipart)
//            return .success(response.contents)
//        } catch {
//            if let apiError = error as? APIError {
//                return .failure(apiError)
//            } else {
//                return .failure(APIError.unknown)
//            }
//        }
//    }
//}
