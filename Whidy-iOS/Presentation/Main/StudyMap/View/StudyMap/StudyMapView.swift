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
    @State var text = ""
    
    var body: some View {
        WithPerceptionTracking {
            ZStack(alignment:.top) {
                filterBtn
                    .zIndex(1)
                    .opacity(store.isSpecificLocation ? 0 : 1)
                
                specificSearchBtn
                    .zIndex(1)
                    .opacity(store.isSpecificLocation ? 1 :0)
                
                placeAddBtn
                    .zIndex(1) // 버튼이 항상 위에 보이도록 설정
                    .opacity(store.isSpecificLocation ? 0 : 1)
                
                MapView()
                    .ignoresSafeArea(edges: [.horizontal, .bottom])
                    .zIndex(0)
            }
            .onAppear {
                store.send(.viewTransition(.onAppear))
            }
        }
    }
}
