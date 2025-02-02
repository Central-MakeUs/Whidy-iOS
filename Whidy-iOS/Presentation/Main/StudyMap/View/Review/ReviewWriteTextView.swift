//
//  ReviewWriteTextView.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 2/2/25.
//

import SwiftUI
import ComposableArchitecture

struct ReviewWriteTextView: View {
    @Perception.Bindable var store: StoreOf<ReviewWriteTextFeature>
    
    var body: some View {
        WithPerceptionTracking {
            VStack {
                Text("ReviewWriteTextView")
            }
        }
    }
}
