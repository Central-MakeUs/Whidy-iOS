//
//  InfoDetailView.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 2/1/25.
//

import SwiftUI

struct InfoDetailView: View {
    @Perception.Bindable var store: StoreOf<InfoDetailFeature>
    @State private var scrollOffset: CGFloat = 0
    @State private var dragOffset: CGFloat = 0

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(0..<50) { index in
                        Text("Item \(index)")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                    }
                }
                .background(GeometryReader { geometry in
                    Color.clear
                        .preference(
                            key: ScrollOffsetKey.self,
                            value: geometry.frame(in: .named("scrollView")).origin.y
                        )
                })
            }
            .coordinateSpace(name: "scrollView")
            .onPreferenceChange(ScrollOffsetKey.self) { value in
                scrollOffset = value // ScrollView의 오프셋 업데이트
                Logger.debug("scrollOffset: \(scrollOffset)")
                
                if scrollOffset >= 150 {
                    store.send(.viewTransition(.dismiss))
                }
            }
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

// ScrollView의 오프셋을 감지하기 위한 PreferenceKey
struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

import ComposableArchitecture

@Reducer
struct InfoDetailFeature {
    @ObservableState
    struct State : Equatable {
        let id = UUID()
        
    }
    
    enum Action : BindableAction {
        case binding(BindingAction<State>)
        case networkResponse(NetworkReponse)
        case buttonTapped(ButtonTapped)
        case viewTransition(ViewTransition)
        case anyAction(AnyAction)
    }
    
    enum ViewTransition {
        case onAppear
        case dismiss
    }
    
    enum NetworkReponse {
        
    }
    
    enum ButtonTapped {
        
    }
    
    
    enum AnyAction {
        
    }
    
    @Dependency(\.networkManager) var networkManager
    
    var body : some ReducerOf<Self> {
        
        BindingReducer()
        
        Reduce { state, action in
            switch action {
                
                
            default :
                break
            }
            return .none
        }
    }
}
