//
//  Encodable+Extension.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 2/2/25.
//

import Foundation
import Alamofire

extension Encodable {
    func toDictionary() -> [String: Any]? {
        do {
            let data = try JSONEncoder().encode(self)
            let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            return dictionary
        } catch {
            Logger.error("Error converting to dictionary: \(error)")
            return nil
        }
    }
}
