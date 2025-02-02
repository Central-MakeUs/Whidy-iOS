//
//  NetworkManager+Place.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 2/2/25.
//

import Foundation
import Alamofire

extension NetworkManager {
    func getPlace(condition : PlaceSearchCondition) async -> Result<[Place], APIError> {
        do {
            let response = try await requestAPI(router: PlaceRouter.place(condition: condition), of: [PlaceDTO].self)
            return .success(response.map { Place(dto: $0) })
            
        } catch {
            if let apiError = error as? APIError {
                return .failure(apiError)
            } else {
                return .failure(APIError.unknown)
            }
        }
    }
}
