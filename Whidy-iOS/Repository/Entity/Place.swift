//
//  Place.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 2/2/25.
//

import Foundation
import CoreData

struct Place: Identifiable, Equatable {
    let id: Int
    var name: String
    let address: String
    let latitude: Double
    let longitude: Double
    let beveragePrice: Int?
    let reviewScore: Double?
    let placeType: PlaceType

    enum PlaceType: String, Equatable {
        case studyCafe = "STUDY_CAFE"
        case generalCafe = "GENERAL_CAFE"
        case franchiseCafe = "FRANCHISE_CAFE"
        case freeStudySpace = "FREE_STUDY_SPACE"
        
        var caseTitle : String {
            switch self {
            case .freeStudySpace: return "무료 공부 공간"
            case .franchiseCafe: return "프랜차이즈 카페"
            case .generalCafe: return "개인 카페"
            case .studyCafe: return "스터디 카페"
                
            }
        }
    }
    
    static func == (lhs: Place, rhs: Place) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Place {
    init() {
        self.id = .init()
        self.name = .init()
        self.address = .init()
        self.latitude = .init()
        self.longitude = .init()
        self.beveragePrice = .init()
        self.reviewScore = .init()
        self.placeType = .generalCafe
    }
    
    init(dto: PlaceDTO) {
        self.id = dto.id
        self.name = dto.name
        self.address = dto.address
        self.latitude = dto.latitude
        self.longitude = dto.longitude
        self.beveragePrice = dto.beveragePrice
        self.reviewScore = dto.reviewScore
        self.placeType = PlaceType(rawValue: dto.placeType) ?? .generalCafe
    }
}
