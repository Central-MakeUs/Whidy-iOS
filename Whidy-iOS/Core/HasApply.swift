//
//  HasApply.swift
//  z-car
//
//  Created by Namuplanet on 9/16/24.
//

import Foundation

protocol HasApply { }

extension HasApply {
    func apply(closure: (Self) -> Void) -> Self {
        closure(self)
        return self
    }
}

extension NSObject: HasApply { }
