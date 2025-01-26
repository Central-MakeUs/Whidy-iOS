//
//  CustomTabBar.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/18/25.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: MainCoordinator.Tab
    
    var body : some View {
        HStack(alignment: .center) {
            Button {
                selectedTab = .studyMap
            } label: {
                VStack(spacing:8) {
                    //FIXME: - 이미지 추가되면 수정
                    ///Image(selectedTab == .calendar ? "calendarSelected" : "calendarUnSelected")
                    ///
                    Text("지도")
                        .fontModifier(fontSize: 10, weight: .bold, color: selectedTab == .studyMap ? ColorSystem.tabbarActive.rawValue : ColorSystem.tabbarUnactive.rawValue)
                }
                .offset(x:-5)
            }
            
            Button {
                selectedTab = .scrap
            } label: {
                VStack(spacing:8) {
                    //FIXME: - 이미지 추가되면 수정
                    ///Image(selectedTab == .calendar ? "calendarSelected" : "calendarUnSelected")
                    ///
                    Text("스크랩")
                        .fontModifier(fontSize: 10, weight: .bold, color: selectedTab == .scrap ? ColorSystem.tabbarActive.rawValue : ColorSystem.tabbarUnactive.rawValue)
                }
            }
            
            
            Button {
                selectedTab = .myPage
            } label: {
                VStack(spacing:8) {
                    //FIXME: - 이미지 추가되면 수정
                    ///Image(selectedTab == .calendar ? "calendarSelected" : "calendarUnSelected")
                    ///
                    Text("마이페이지")
                        .fontModifier(fontSize: 10, weight: .bold, color: selectedTab == .myPage ? ColorSystem.tabbarActive.rawValue : ColorSystem.tabbarUnactive.rawValue)
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: 30)
        .background(.red)
    }
}
