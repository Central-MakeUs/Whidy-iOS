//
//  InfoView.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 2/1/25.
//

import SwiftUI
import ComposableArchitecture

//TODO: - Place ID 기준으로 상세조회 API 적용해야됨

struct InfoView: View {
    
    @Perception.Bindable var store : StoreOf<InfoFeautre>
    
    var body: some View {
        WithPerceptionTracking {
            ZStack(alignment:.top) {
                GeometryReader { geometry in
                    Color.clear
                        .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .global).minY)
                }
                .frame(height: 0)
                
                Capsule()
                    .frame(width: 34, height: 3)
                    .foregroundColor(Color(hex: ColorSystem.graye8e9ed.rawValue))
                    .padding(.top, 6)
                
                ScrollView {
                    VStack {
                        Text("hi")
                    }
                }
                .padding(.top, 30)
            }
            .background(Color.white)
            .onAppear {
                Logger.debug("\(store.currentPlace) ✅")
            }
        }
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
