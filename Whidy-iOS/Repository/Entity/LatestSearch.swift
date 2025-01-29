//
//  LatestSearch.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/29/25.
//

import RealmSwift
import Foundation

final class LatestSearch: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var keyword: String
    @Persisted var regDt: Date = Date()
}

extension LatestSearch {
    // static을 사용해 타입 프로퍼티로 선언
    // 여기서 선언한 realm을 사용해 저장, 삭제등을 진행한다.
    private static var realm = try! Realm()
    
    // realm객체에 값을 추가
    static func addRow(_ search: LatestSearch) {
        try! realm.write {
            realm.add(search)
        }
    }
    
    // realm객체의 값을 삭제
    static func delRow(_ search: LatestSearch) {
        try! realm.write {
            realm.delete(search)
        }
    }
    
    static func delRowAll() {
        try! realm.write {
            realm.deleteAll()
        }
    }
}
