//
//  ReviewWriteFilterView.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 2/2/25.
//

import SwiftUI
import ComposableArchitecture

struct ReviewWriteFilterView: View {
    @Perception.Bindable var store: StoreOf<ReviewWriteFilterFeature>
    
    var body: some View {
        WithPerceptionTracking {
            VStack {
                Text("ReviewWriteFilterView")
            }
        }
    }
}
