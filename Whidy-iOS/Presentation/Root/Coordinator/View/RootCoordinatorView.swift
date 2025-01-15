//
//  RootCoordinatorView.swift
//  Whidy-iOS
//
//  Created by Namuplanet on 1/14/25.
//

import SwiftUI
import ComposableArchitecture

struct RootCoordinatorView: View {
    @State var store : StoreOf<RootCoordinator>
    
    var body: some View {
        WithPerceptionTracking {
            ZStack {
                if store.isLoggined {
                    MainCoordinatorView(store: store.scope(state: \.main, action: \.main))
                        .transition(.opacity.animation(.easeIn))
                        .zIndex(1)
                } else {
                    OnboardingCoordinatorView(store: store.scope(state: \.onboarding, action: \.onboarding))
                        .transition(.opacity.animation(.easeIn))
                        .zIndex(1)
                }
            }
            .onAppear {
                store.send(.viewTransition(.onAppear))
            }
            .onDisappear {
                
            }
        }
    }
}
