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
                VStack {
                    HStack {
                        TextField("", text: $text)
                            .padding(.leading, 16) // 왼쪽 패딩 추가
                            .frame(height: 38) // 고정 높이 설정
                            .background(
                                HStack {
                                    Text("원하는 공간을 검색해보세요")
                                        .fontModifier(fontSize: 16, weight: .regular, color: ColorSystem.grayG300.rawValue)
                                        .padding(.leading, 16) // 플레이스홀더 왼쪽 패딩
                                    Spacer()
                                    Image(.search)
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .padding(.trailing, 10) // 이미지 오른쪽 패딩
                                }
                            )
                            .background(Color.white)
                            .cornerRadius(4) // 모서리 둥글게
                            .overlay(
                                RoundedRectangle(cornerRadius: 4) // 테두리
                                    .stroke(Color(hex: ColorSystem.grayG100.rawValue), lineWidth: 1) // 테두리 색상과 두께
                            )
                            .frame(maxWidth: .infinity)
                            .disabled(true)
                    }
                    .padding(.horizontal, 14)
                }
                .background(
                    Rectangle()
                        .fill(Color(hex: ColorSystem.white.rawValue))
                )
                .zIndex(1)
                
                MapView()
                    .ignoresSafeArea(edges: [.horizontal, .bottom])
                    .zIndex(0)
            }
        }
    }
}

