//
//  MyPageScreen+Identifiable.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/15/25.
//

extension MyPageScreen.State : Identifiable {
    var id : ID {
        switch self {
        case .myPage:
                .myPage
        }
    }
    
    enum ID : Identifiable {
        case myPage
        var id: ID { self }
    }
}
