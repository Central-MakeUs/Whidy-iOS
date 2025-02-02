//
//  Place.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 2/2/25.
//

import Foundation
import CoreData

struct Place: Identifiable {
    let id: Int64
    let name: String
    let address: String
    let latitude: Double
    let longitude: Double
    let beveragePrice: Int
    let reviewScore: Float
    let placeType: PlaceType

    enum PlaceType: String {
        case studyCafe = "STUDY_CAFE"
        case generalCafe = "GENERAL_CAFE"
        case franchiseCafe = "FRANCHISE_CAFE"
        case freePicture = "FREE_PICTURE"
        case freeStudySpace = "FREE_STUDY_SPACE"
        case freeClothesRental = "FREE_CLOTHES_RENTAL"
    }
}

extension Place {
    init(dto: PlaceDTO) {
        self.id = dto.id
        self.name = dto.name
        self.address = dto.address
        self.latitude = dto.latitude
        self.longitude = dto.longitude
        self.beveragePrice = dto.beveragePrice
        self.reviewScore = dto.reviewScore
        self.placeType = PlaceType(rawValue: dto.placeType.rawValue) ?? .generalCafe
    }
}
