//
//  AppVersionResponse.swift
//  z-car
//
//  Created by Namuplanet on 8/26/24.
//

import Foundation

struct AppVersionResponse : Decodable {
    var currentVersion: String?
    var forceUpdate: Bool?
    var lastVersion: String?
    var message: String?
    
    enum CodingKeys: String, CodingKey {
        case currentVersion
        case forceUpdate
        case lastVersion
        case message
    }
}

extension AppVersionResponse {
    func toDomain() -> AppVersionInfo {
        return .init(currentVersion: currentVersion,
                     forceUpdate: forceUpdate,
                     lastVersion: lastVersion,
                     message: message)
    }
}
