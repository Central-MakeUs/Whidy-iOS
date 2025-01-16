//
//  ScrapScreen+Identifiable.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/15/25.
//

extension ScrapScreen.State : Identifiable {
    var id : ID {
        switch self {
        case .scrap:
                .scrap
        }
    }
    
    enum ID : Identifiable {
        case scrap
        var id: ID { self }
    }
}
