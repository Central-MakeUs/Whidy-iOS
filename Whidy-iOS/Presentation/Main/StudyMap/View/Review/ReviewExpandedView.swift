//
//  ReviewExpandedView.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 2/2/25.
//

import SwiftUI
import ComposableArchitecture

struct ReviewExpandedView: View {
    @Perception.Bindable var store: StoreOf<ReviewExpandedFeature>
    
    var body: some View {
        WithPerceptionTracking {
            VStack {
                Text("ReviewView")
            }
        }
    }
}

