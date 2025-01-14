//
//  Publisher+Extension.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 9/16/24.
//

import Foundation
import Combine

extension Publisher {
  func withUnretained<O: AnyObject>(_ owner: O) -> Publishers.CompactMap<Self, (O, Self.Output)> {
    compactMap { [weak owner] output in
      owner == nil ? nil : (owner!, output)
    }
  }
}
