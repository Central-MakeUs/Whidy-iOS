//
//  ScrapView.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/15/25.
//

import SwiftUI
import ComposableArchitecture

struct ScrapView: View {
    @Perception.Bindable var store: StoreOf<ScrapFeature>
    
    var body: some View {
        WithPerceptionTracking {
            VStack {
                Text("ScrapView")
            }
        }
    }
}
