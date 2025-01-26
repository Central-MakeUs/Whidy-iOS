//
//  MapView.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/18/25.
//

import SwiftUI
import NMapsMap

struct MapView: UIViewRepresentable {    
    func makeCoordinator() -> NaverMapManager {
        return NaverMapManager.shared
    }
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        context.coordinator.getNaverMapView()
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {}
}


