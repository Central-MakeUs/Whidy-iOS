//
//  CafeDTO.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 2/3/25.
//

import Foundation

// MARK: - Welcome
struct CafeDTO: Decodable {
    let id: Int
    let name, address: String
    let latitude, longitude: Double
    let beveragePrice, reviewNum : Int
    let reviewScore: Double?
    let placeType: String
    let additionalInfo: AdditionalInfo
    let businessHours: [BusinessHour]
}

// MARK: - AdditionalInfo
struct AdditionalInfo: Decodable {
    let type: String
    let menu: [Menu]

    enum CodingKeys: String, CodingKey {
        case type = "@type"
        case menu
    }
}

// MARK: - Menu
struct Menu: Decodable {
    let name, price: String
    let image: String?
}

// MARK: - BusinessHour
struct BusinessHour: Decodable {
    let dayOfWeek: String
    let openTime, closeTime: String?
}
