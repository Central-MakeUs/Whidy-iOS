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
                    HStack(spacing:0){
                        searchBar
                            .onTapGesture {
                                Logger.debug("SearchBar Tab ---> to SearchView")
                            }
                        
                        Spacer()
                        
                        Image(.btnFilter)
                            .resizable()
                            .frame(width: 38, height: 38)
                            .asButton {
                                Logger.debug("Filter Btn")
                            }
                            .padding(.leading, 6)
                    }
                    .padding(.horizontal, 14)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) { // 요소 간 간격 설정
                            ForEach(store.filterCase) { item in
                                Text(item.caseTitle)
                                    .fontModifier(fontSize: 14, weight: .semibold, color: ColorSystem.grayG800.rawValue)
                                    .padding(.horizontal, 12)
                                    .frame(height: 34, alignment: .center)
                                    .background(
                                        RoundedRectangle(cornerRadius: 17)
                                            .fill(Color(hex: ColorSystem.grayG100.rawValue))
                                    )
                            }
                        }
                        .padding(.horizontal, 14)
                        .padding(.bottom, 6)
                    }
                    .frame(height: 35)
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

extension StudyMapView {
    var searchBar : some View {
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
            .cornerRadius(8) // 모서리 둥글게
            .overlay(
                RoundedRectangle(cornerRadius: 8) // 테두리
                    .stroke(Color(hex: ColorSystem.grayG100.rawValue), lineWidth: 1) // 테두리 색상과 두께
            )
            .frame(maxWidth: .infinity)
            .disabled(true)
    }
}
