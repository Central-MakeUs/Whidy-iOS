//
//  StudyMapScreen+Identifiable.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/15/25.
//

extension StudyMapScreen.State : Identifiable {
    var id : ID {
        switch self {
        case .studyMap:
                .studyMap
        case .search:
                .search
        case .infoDetail:
                .infoDetail
        case .reviewExpanded:
                .reviewExpanded
        case .reviewWriteFilter:
                .reviewWriteFilter
        case .reviewWriteText:
                .reviewWriteText
        
        }
    }
    
    enum ID : Identifiable {
        case studyMap
        case search
        case infoDetail
        case reviewExpanded
        case reviewWriteFilter
        case reviewWriteText
        var id: ID { self }
    }
}
