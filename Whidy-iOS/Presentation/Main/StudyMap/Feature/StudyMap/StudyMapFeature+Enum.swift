//
//  StudyMapFeature+Enum.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/29/25.
//

import Foundation

enum MapFilterCase : CaseIterable, Hashable, Identifiable {
    case FREE_STUDY_SPACE
    case FRANCHISE_CAFE
    case GENERAL_CAFE
    case STUDY_CAFE
//    case FREE_CLOTHES_RENTAL
//    case FREE_PICTURE
    
    var caseTitle : String {
        switch self {
        case .FREE_STUDY_SPACE: return "무료 공부 공간"
        case .FRANCHISE_CAFE: return "프랜차이즈 카페"
        case .GENERAL_CAFE: return "개인 카페"
        case .STUDY_CAFE: return "스터디 카페"
//        case .FREE_CLOTHES_RENTAL: return "정장 대여"
//        case .FREE_PICTURE: return "면접 사진"
        }
    }
    
    var placeType : String {
        switch self {
        case .FREE_STUDY_SPACE : return "FREE_STUDY_SPACE"
        case .FRANCHISE_CAFE : return "FRANCHISE_CAFE"
        case .GENERAL_CAFE : return "GENERAL_CAFE"
        case .STUDY_CAFE : return "STUDY_CAFE"
//        case .FREE_CLOTHES_RENTAL: return "FREE_CLOTHES_RENTAL"
//        case .FREE_PICTURE: return "FREE_PICTURE"
        }
    }
    
    var placeRadius : Double {
        switch self {
        case .FREE_STUDY_SPACE : return 9999999 /// 반경 제한 없음
        default: return 5000 /// 5km, naverMak 줌 레벨 14정도
        }
    }
    
    init?(from string: String) {
        switch string {
        case "FREE_STUDY_SPACE":
            self = .FREE_STUDY_SPACE
        case "FRANCHISE_CAFE":
            self = .FRANCHISE_CAFE
        case "GENERAL_CAFE":
            self = .GENERAL_CAFE
        case "STUDY_CAFE":
            self = .STUDY_CAFE
//        case "FREE_CLOTHES_RENTAL":
//            self = .FREE_CLOTHES_RENTAL
//        case "FREE_PICTURE":
//            self = .FREE_PICTURE
        default:
            return nil
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
