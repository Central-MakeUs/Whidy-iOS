//
//  InfoDetailView.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 2/1/25.
//

import SwiftUI
import ComposableArchitecture

struct InfoDetailView: View {
    @Perception.Bindable var store: StoreOf<InfoDetailFeature>
    @State private var scrollOffset: CGFloat = 0
    @State private var dragOffset: CGFloat = 0

    var body: some View {
        WithPerceptionTracking {
            VStack {
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(0..<5) { index in
                            Text("Item \(index)")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                        }
                    }
                    .background(GeometryReader { geometry in
                        Color.clear
                            .preference(
                                key: ScrollOffsetKey.self,
                                value: geometry.frame(in: .named("scrollView")).origin.y
                            )
                    })
                }
                .coordinateSpace(name: "scrollView")
                .onPreferenceChange(ScrollOffsetKey.self) { value in
                    scrollOffset = value // ScrollView의 오프셋 업데이트
                    Logger.debug("scrollOffset: \(scrollOffset)")
                    
                    if scrollOffset >= 150 {
                        store.send(.viewTransition(.dismiss))
                    }
                }
            }
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
            .padding(.top, getSafeAreaTop())
        }
    }
}

// ScrollView의 오프셋을 감지하기 위한 PreferenceKey
struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
