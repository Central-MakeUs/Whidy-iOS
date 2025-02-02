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
