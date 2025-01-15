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
        }
    }
    
    enum ID : Identifiable {
        case studyMap
        var id: ID { self }
    }
}
