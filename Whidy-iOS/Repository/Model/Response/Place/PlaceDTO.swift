//
//  PlaceDTO.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 2/2/25.
//

import Foundation

struct PlaceDTO: Decodable {
    let id: Int
    let name, address: String
    let latitude, longitude: Double
    let beveragePrice: Int?
    let reviewScore: Double?
    let placeType: String
}
