//
//  MyPageScreen.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/15/25.
//

import Foundation
import ComposableArchitecture

@Reducer(state: .equatable)
enum MyPageScreen {
    case myPage(MyPageFeature)
}
