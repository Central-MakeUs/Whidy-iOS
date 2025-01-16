//
//  OnboardingScreen.swift
//  Whidy-iOS
//
//  Created by Namuplanet on 1/14/25.
//

import Foundation
import ComposableArchitecture

@Reducer(state: .equatable)
enum OnbaordingScreen {
    case auth(AuthFeature)
    case web(WebFeature)
}

