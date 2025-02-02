//
//  PlaceDTO.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 2/2/25.
//

import Foundation

struct PlaceDTO: Decodable {
    let id: Int64
    let name: String
    let address: String
    let latitude: Double
    let longitude: Double
    let beveragePrice: Int
    let reviewScore: Float
    let placeType: PlaceType

    enum PlaceType: String, Decodable {
        case studyCafe = "STUDY_CAFE"
        case generalCafe = "GENERAL_CAFE"
        case franchiseCafe = "FRANCHISE_CAFE"
        case freePicture = "FREE_PICTURE"
        case freeStudySpace = "FREE_STUDY_SPACE"
        case freeClothesRental = "FREE_CLOTHES_RENTAL"
    }
}
