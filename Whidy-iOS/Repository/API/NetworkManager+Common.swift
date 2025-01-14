//
//  NetworkManager+Common.swift
//  z-car
//
//  Created by Namuplanet on 8/26/24.
//

import Foundation
import Alamofire

extension NetworkManager {
    func appVersion() async -> Result<AppVersionInfo, APIError> {
        do {
            let response = try await requestAPI(router: CommonRouter.appVersion, of: RemoteResponse<AppVersionResponse>.self)
            return .success(response.contents.toDomain())
        } catch {
            if let apiError = error as? APIError {
                return .failure(apiError)
            } else {
                //FIXME: - errorHandling 필요
                return .failure(APIError.unknown)
            }
        }
    }
}
