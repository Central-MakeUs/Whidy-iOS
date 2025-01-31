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
                ZStack(alignment:.top) {
                    latestSearchView
                    searchResult
                }
                .padding(.horizontal, 14)
                .padding(.top, 30)
                .onAppear {
                    UIApplication.shared.addTapGestureRecognizer() /// keyboard hide
                    Logger.debug(Realm.Configuration.defaultConfiguration.fileURL ?? "")
                }
                .customNavigationBar(
                    backButtonAction: {
                        store.send(.viewTransition(.goToBack))
                    },
                    userInput: $store.userInput,
                    onSubmit: {
                        store.send(.buttonTapped(.userInputSubmit))
                    },
                    onEditing: {
                        store.send(.anyAction(.isSearchBarEditing($0)))
                    },
                    geometry: geometry)
            }
        }
    }
}

extension SearchView {
    var latestSearchView : some View {
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
            }.opacity(store.isHideLatestSearch || store.isSearchSuccess ? 0 : 1)
            
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
    }
    
    var searchResult : some View {
        ScrollView {
            LazyVStack(spacing: 10) { // 항목 간 간격 설정
                ForEach(store.searchResult, id: \.id) { item in
                    VStack(spacing: 3) {
                        Text(item.placeName)
                            .fontModifier(fontSize: 14, weight: .bold, color: ColorSystem.black.rawValue)
                            .align(.leading)
                        Text(item.address)
                            .fontModifier(fontSize: 11, weight: .semibold, color: ColorSystem.grayG300.rawValue)
                            .align(.leading)
                    }
                    .onTapGesture {
                        store.send(.viewTransition(.goToResultLocation(item)))
                    }
                    .padding(.vertical, 8)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                }
            }
            .padding(.horizontal) // 좌우 패딩 추가
        }
        .opacity(store.isOnSearchResult && store.isSearchSuccess ? 1 : 0)
        
    }
}

extension View {
    func customNavigationBar(backButtonAction: @escaping () -> Void, userInput: Binding<String>, onSubmit: @escaping () -> Void, onEditing: @escaping (Bool) -> Void, geometry: GeometryProxy) -> some View {
        self
            .toolbar(.hidden, for: .tabBar)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack(spacing: 0) {
                        // Back Button
                        BackButton(action: backButtonAction)
                        
                        // TextField
                        TextField("원하는 공간을 검색해보세요", text: userInput, onEditingChanged: { editing in
                            onEditing(editing)
                        })
                            .fontModifier(fontSize: 16, weight: .semibold, color: ColorSystem.grayG900.rawValue)
                            .frame(width: geometry.size.width - 85, height: 38)
                            .padding(.horizontal, 16)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(hex: ColorSystem.grayG100.rawValue), lineWidth: 1)
                            )
                            .onSubmit {
                                onSubmit()
                            }
                    }
                }
            }
    }
}
