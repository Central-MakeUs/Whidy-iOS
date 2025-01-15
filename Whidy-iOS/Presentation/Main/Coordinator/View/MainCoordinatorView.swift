//
//  MainCoordinatorView.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/15/25.
//

import SwiftUI
import ComposableArchitecture

struct MainCoordinatorView: View {
    @Perception.Bindable var store : StoreOf<MainCoordinator>
    
    var body: some View {
        WithPerceptionTracking {
            ZStack {
                TabView(selection: $store.selectedTab.sending(\.tabSelected)) {
                    StudyMapCoordinatorView(store: store.scope(state: \.studyMap, action: \.studyMap))
                        .tabItem {
//                            Image(store.selectedTab == .home ? .homeTabActive : .homeTabInActive)
                            Text("지도")
                                .tabItemFont()
                        }
                        .tag(MainCoordinator.Tab.studyMap)
                }
                .zIndex(0)
            }
        }
    }
}
