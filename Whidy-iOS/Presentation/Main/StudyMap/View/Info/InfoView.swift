//
//  InfoView.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 2/1/25.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                Color.clear
                    .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .global).minY)
            }
            .frame(height: 0)
            
            VStack {
                Text("hi")
                Text("hi")
                Text("hi")
                Text("hi")
                Text("hi")
            }
        }
        .padding(.top, 30)
        .cornerRadius(17)
        .background(Color.white)
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
