//
//  Whidy_iOSApp.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/4/25.
//

import SwiftUI
import ComposableArchitecture

@main
struct Whidy_iOSApp: App {
    var body: some Scene {
        WindowGroup {
            RootCoordinatorView(store: Store(initialState: .initialState, reducer: {
                RootCoordinator()
            }))
        }
    }
}
