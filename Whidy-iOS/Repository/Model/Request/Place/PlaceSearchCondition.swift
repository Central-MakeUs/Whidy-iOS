//
//  PlaceSearchCondition.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 2/2/25.
//

import Foundation

struct PlaceSearchCondition: Encodable {
    var reviewScoreFrom: Int?
    var reviewScoreTo: Int?
    var beverageFrom: Int?
    var beverageTo: Int?
    var placeType: [String] = .init()
    var businessDayOfWeek: [String]?
    var visitTimeFrom: LocalTime?
    var visitTimeTo: LocalTime?
    var centerLatitude: Double
    var centerLongitude: Double
    var radius: Double
    var keyword: String = .init()

    enum CodingKeys: String, CodingKey {
        case reviewScoreFrom
        case reviewScoreTo
        case beverageFrom
        case beverageTo
        case placeType
        case businessDayOfWeek
        case visitTimeFrom
        case visitTimeTo
        case centerLatitude
        case centerLongitude
        case radius
        case keyword
    }
}

struct LocalTime: Encodable {
    var hour: Int
    var minute: Int
    var second: Int
    var nano: Int
}
