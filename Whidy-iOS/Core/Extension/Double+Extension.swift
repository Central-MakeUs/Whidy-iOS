//
//  Double+Extension.swift
//  z-car
//
//  Created by Namuplanet on 9/19/24.
//

import Foundation

extension Double {
    enum RoundLength : String {
        case zero = "%.0f"
        case one = "%.1f"
        case two = "%.2f"
        case three = "%.3f"
        case full
    }
    
    func toString(length: RoundLength = .one) -> String {
        switch length {
        case .full:
            return "\(self)" // 소수점 제한 없이 전체 값 출력
        default:
            return String(format: length.rawValue, self) // 지정된 소수점 형식 출력
        }
    }
        
    var isZero: Bool {
        return self == 0
    }
}
