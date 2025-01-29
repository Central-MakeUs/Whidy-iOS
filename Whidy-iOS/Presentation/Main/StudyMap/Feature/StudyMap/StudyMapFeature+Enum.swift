//
//  StudyMapFeature+Enum.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/29/25.
//

import Foundation

enum MapFilterCase : CaseIterable, Hashable, Identifiable {
    case free
    case franchise
    case study
    case library
    case personal
    
    var caseTitle : String {
        switch self {
        case .free: return "무료공간"
        case .franchise: return "프랜차이즈 카페"
        case .study: return "스터디 카페"
        case .library: return "도서관"
        case .personal: return "개인 카페"
        }
    }
    
    var id: Self { self }
    
    static func getAllFilters() -> [MapFilterCase] {
        return MapFilterCase.allCases
    }
    
    static var allTitles: [String] {
        return MapFilterCase.allCases.map { $0.caseTitle }
    }
}
