//
//  SearchView.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/29/25.
//

import SwiftUI
import ComposableArchitecture

struct SearchView: View {
    @Perception.Bindable var store: StoreOf<SearchFeature>
    
    var body: some View {
        WithPerceptionTracking {
            NavigationStack {
                VStack {
                    Text("SearchView")
                }
                .onAppear {
                    
                }
            }
        }
    }
}
