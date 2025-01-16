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
    @SwiftUI.Environment(\.scenePhase) var scenePhase
    @State var isSplashView = true
    
    init() {
        Logger.configurations()
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if isSplashView {
                    WhidySplashView()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                isSplashView = false
                            }
                        }
                } else {
                    RootCoordinatorView(store: Store(initialState: .initialState, reducer: {
                        RootCoordinator()
                    }))
                }
            }
        }
    }
}
