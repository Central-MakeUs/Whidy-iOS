//
//  SearchView.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/29/25.
//

import SwiftUI
import RealmSwift
import ComposableArchitecture

struct SearchView: View {
    @Perception.Bindable var store: StoreOf<SearchFeature>
    @ObservedResults(LatestSearch.self, sortDescriptor: SortDescriptor(keyPath: "regDt", ascending: false)) var latestSearch
    
    var body: some View {

        GeometryReader { geometry in
            WithPerceptionTracking {
                VStack {
                    HStack {
                        Text("최근 검색")
                            .fontModifier(fontSize: 14, weight: .semibold, color: ColorSystem.grayG800.rawValue)
                        
                        Spacer()
                        
                        Text("전체 삭제")
                            .fontModifier(fontSize: 12, weight: .regular, color: ColorSystem.grayG500.rawValue)
                            .asButton {
                                store.send(.buttonTapped(.removeLatestSearch))
                            }
                    }.opacity(store.isHideLatestSearch ? 0 : 1)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) { // 요소 간 간격 설정
                            ForEach(latestSearch) { item in
                                Text(item.keyword)
                                    .fontModifier(fontSize: 12, weight: .semibold, color: ColorSystem.grayG500.rawValue)
                                    .padding(.horizontal, 18)
                                    .frame(height: 39, alignment: .center)
                                    .background(
                                        RoundedRectangle(cornerRadius: 24)
                                            .stroke(Color(hex: ColorSystem.grayG100.rawValue), lineWidth: 1)
                                    )
                            }
                        }
                    }.opacity(store.isHideLatestSearch ? 0 : 1)
                }
                .padding(.horizontal, 14)
                .padding(.top, 30)
                .onAppear {
                    UIApplication.shared.addTapGestureRecognizer() /// keyboard hide
                    Logger.debug(Realm.Configuration.defaultConfiguration.fileURL ?? "")
                }
                .toolbar(.hidden, for: .tabBar)
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        HStack(spacing:0) {
                            BackButton {
                                store.send(.viewTransition(.goToBack))
                            }
                            
                            TextField("원하는 공간을 검색해보세요", text: $store.userInput)
                                .fontModifier(fontSize: 16, weight: .semibold, color: ColorSystem.grayG900.rawValue)
                                .frame(width: geometry.size.width - 85, height: 38)
                                .padding(.horizontal, 16)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(hex: ColorSystem.grayG100.rawValue), lineWidth: 1) // 테두리 색상과 두께
                                )
                        }
                    }
                }
            }
        }
    }
}
