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
                    
                    ScrapCoordinatorView(store: store.scope(state: \.scrap, action: \.scrap))
                        .tabItem {
//                            Image(store.selectedTab == .home ? .homeTabActive : .homeTabInActive)
                            Text("스크랩")
                                .tabItemFont()
                        }
                        .tag(MainCoordinator.Tab.scrap)
                    
                    MyPageCoordinatorView(store: store.scope(state: \.myPage, action: \.myPage))
                        .tabItem {
//                            Image(store.selectedTab == .home ? .homeTabActive : .homeTabInActive)
                            Text("마이")
                                .tabItemFont()
                        }
                        .tag(MainCoordinator.Tab.myPage)
                }
                .zIndex(0)
            }
        }
    }
}
