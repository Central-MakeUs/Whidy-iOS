//
//  MyPageView.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/15/25.
//

import SwiftUI
import ComposableArchitecture

struct MyPageView: View {
    @Perception.Bindable var store: StoreOf<MyPageFeature>
    
    var body: some View {
        WithPerceptionTracking {
            VStack {
                Text("MyPageView")
            }
        }
    }
}
