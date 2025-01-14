//
//  LoginType.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 8/27/24.
//

import Foundation

enum PublicLoginType : String {
    case ID = "01"
    case KAKAO = "02"
    case NAVER = "03"
    case GOOGLE = "04"
    case APPLE = "05"
    
    var typeToRaw : String {
        switch self {
        case .ID:
            return "이메일/패스워드"
        case .KAKAO:
            return "카카오"
        case .NAVER:
            return "네이버"
        case .GOOGLE:
            return "구글"
        case .APPLE:
            return "애플"
        }
    }
}
