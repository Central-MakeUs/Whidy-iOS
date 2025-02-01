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
    @State private var dragOffset: CGFloat =  0
    @State private var currentOffset: CGFloat = 0
    @State private var isBottomSheetFull : Bool = false
    
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
                dragOffset = SheetHeight.bottom
                currentOffset = SheetHeight.bottom
            }
            .overlay {
                if store.isShowInfoDetial {
                    InfoView()
                        .disabled(true)
                        .frame(height: UIScreen.main.bounds.size.height)
                        .offset(y: dragOffset)
                        .gesture(DragGesture()
                            .onChanged { gesture in
                                Logger.debug("onChanged - \(gesture.translation.height)")
                                dragOffset = gesture.translation.height + currentOffset
                            }
                            .onEnded { gesture in
                                Logger.debug("onEnded - \(gesture.translation.height)")
                                dragOffset = gesture.translation.height + currentOffset
                                decideSheetHeight()
                            }
                        )
                }
            }
        }
    }
}

extension StudyMapView {
    enum SheetHeight {
        static let bottom = UIScreen.main.bounds.size.height * (5/7)
    }
    enum SheetBoundary {
        static let high = UIScreen.main.bounds.size.height * (1/4)
        static let middle = UIScreen.main.bounds.size.height * (1/2)
        static let low = UIScreen.main.bounds.size.height * (3/4)
    }
    
    private func decideSheetHeight() {
        withAnimation(.easeInOut) {
            if dragOffset > SheetBoundary.low {
                dragOffset = SheetHeight.bottom
                isBottomSheetFull = false
            } else if dragOffset > SheetBoundary.middle {
                dragOffset = SheetHeight.bottom
            } else {
                isBottomSheetFull = true
                dragOffset = SheetHeight.bottom
                store.send(.viewTransition(.goToInfoDetail))
            }
        }
        currentOffset = dragOffset
    }
}
