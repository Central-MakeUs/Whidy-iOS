//
//  Cafe.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 2/3/25.
//

import Foundation

struct Cafe: Identifiable, Equatable {
    let id: Int
    var name: String
    let address: String
    let latitude: Double
    let longitude: Double
    let beveragePrice: Int?
    let reviewNum: Int?
    let reviewScore: Double?
    let placeType: PlaceType
    let additionalInfo: AdditionalInfo
    let businessHours: [BusinessHour]

    enum PlaceType: String, Equatable {
        case studyCafe = "STUDY_CAFE"
        case generalCafe = "GENERAL_CAFE"
        case franchiseCafe = "FRANCHISE_CAFE"
        case freePicture = "FREE_PICTURE"
        case freeStudySpace = "FREE_STUDY_SPACE"
        case freeClothesRental = "FREE_CLOTHES_RENTAL"
    }
    
    static func == (lhs: Cafe, rhs: Cafe) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Cafe {
    init() {
        self.id = .init()
        self.name = .init()
        self.address = .init()
        self.latitude = .init()
        self.longitude = .init()
        self.beveragePrice = .init()
        self.reviewNum = .init()
        self.reviewScore = .init()
        self.placeType = .generalCafe
        self.additionalInfo = AdditionalInfo(type: "", menu: [])
        self.businessHours = []
    }
    
    init(dto: CafeDTO) {
        self.id = dto.id
        self.name = dto.name
        self.address = dto.address
        self.latitude = dto.latitude
        self.longitude = dto.longitude
        self.beveragePrice = dto.beveragePrice
        self.reviewNum = dto.reviewNum
        self.reviewScore = dto.reviewScore
        self.placeType = PlaceType(rawValue: dto.placeType) ?? .generalCafe
        self.additionalInfo = dto.additionalInfo
        self.businessHours = dto.businessHours
    }
}
