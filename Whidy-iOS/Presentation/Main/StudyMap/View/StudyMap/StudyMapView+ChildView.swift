//
//  StudyMapView+ChildView.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/29/25.
//

import SwiftUI

extension StudyMapView {
    var specificSearchBtn : some View {
        VStack {
            HStack(spacing:0){
                TextField("", text: $store.specificLocation.placeName)
                    .padding(.leading, 16) // 왼쪽 패딩 추가
                    .frame(height: 38) // 고정 높이 설정
                    .background(
                        HStack {
                            Text("")
                                .fontModifier(fontSize: 16, weight: .semibold, color: ColorSystem.grayG300.rawValue)
                                .padding(.leading, 16) // 플레이스홀더 왼쪽 패딩
                            Spacer()
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
                    .onTapGesture {
                        Logger.debug("검색 화면 이동")
                    }
                
                Spacer()
                
                Image(.cancelBtn1)
                    .resizable()
                    .frame(width: 38, height: 38)
                    .asButton {
                        Logger.debug("메인 지도 이동")
                    }
                    .padding(.leading, 6)
            }
            .padding(.horizontal, 14)
            .padding(.bottom, 6)
        }
        .background(
            Rectangle()
                .fill(Color(hex: ColorSystem.white.rawValue))
        )
    }
    
    var searchBar : some View {
        TextField("", text: $text)
            .padding(.leading, 16) // 왼쪽 패딩 추가
            .frame(height: 38) // 고정 높이 설정
            .background(
                HStack {
                    Text("원하는 공간을 검색해보세요")
                        .fontModifier(fontSize: 16, weight: .semibold, color: ColorSystem.grayG300.rawValue)
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
            .onTapGesture {
                store.send(.buttonTapped(.search))
            }
    }
    
    var filterBar : some View {
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
    }
    
    var filterBtn : some View {
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
            
            filterBar
                .frame(height: 35)
        }
        .background(
            Rectangle()
                .fill(Color(hex: ColorSystem.white.rawValue))
        )
    }
    
    var placeAddBtn : some View {
        VStack {
            Spacer() // 상단 공간 채우기
            HStack {
                Spacer() // 왼쪽 공간 채우기
                Text("+ 장소 추가")
                    .fontModifier(fontSize: 14, weight: .semibold, color: ColorSystem.white.rawValue)
                    .frame(width: 101, height: 48, alignment: .center)
                    .background(
                        RoundedRectangle(cornerRadius: 40)
                            .fill(Color(hex: ColorSystem.brwonPB800.rawValue))
                    )
                    .padding(.trailing, 14) // 오른쪽 여백
                    .padding(.bottom, 18)  // 아래 여백
                    .onTapGesture {
                        Logger.debug("장소추가 버튼")
                    }
            }
        }
    }
}

