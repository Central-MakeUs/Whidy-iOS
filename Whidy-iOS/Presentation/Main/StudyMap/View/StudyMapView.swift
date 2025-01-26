//
//  StudyMapView.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/15/25.
//

import SwiftUI
import ComposableArchitecture

struct StudyMapView: View {
    @Perception.Bindable var store: StoreOf<StudyMapFeature>
    
    var body: some View {
        WithPerceptionTracking {
            VStack {
                MapView()
                    .ignoresSafeArea(.all)
            }
        }
    }
}

