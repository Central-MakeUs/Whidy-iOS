//
//  SearchFeature.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/29/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct SearchFeature {
    @ObservableState
    struct State : Equatable {
        let id = UUID()
        var userInput : String = .init()
        var isHideLatestSearch : Bool = false
        var isSearchSuccess : Bool = false
        var isOnSearchResult : Bool = false
        
        /// mock Data
        var searchResult : [SearchMockData] = [.init(placeName: "GOC커피", address: "테라타워 A동, 지하1층 G109호 167 송파대로 문정동, 송파구 서울특별시", latitude: 37.4849488, longitude: 127.1208004), .init(placeName: "문정커피", address: "문정동 법조프라자 96 KR 서울특별시 송파구 서울시 송파구 법원로", latitude: 37.4840354, longitude: 127.1210696)]
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
        case goToBack
        case goToResultLocation(SearchMockData)
    }
    
    enum NetworkReponse {
        
    }
    
    enum ButtonTapped {
        case removeLatestSearch
        case userInputSubmit
    }

    enum AnyAction {
        case isSearchBarEditing(Bool)
    }
    
    @Dependency(\.networkManager) var networkManager
    @Dependency(\.naverMapManager) var naverMapManager
    
    var body : some ReducerOf<Self> {
        
        BindingReducer()

        buttonTappedReducer()
        anyActionReducer()
    }
}

extension SearchFeature {
    func buttonTappedReducer() -> some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            
            case .buttonTapped(.removeLatestSearch):
                LatestSearch.delRowAll()
                
            //TODO: - onSubmit 실행시, API 호출 진행되어야 함
            case .buttonTapped(.userInputSubmit):
                Logger.debug("userInputSubmit - \(state.userInput)")
                
                state.isOnSearchResult = true
                state.isSearchSuccess = true
                
                return .run { send in
                    //TODO: - API 연동이후, 데이터 저장 필요
                }
                
            default:
                break
            }
            
            return .none
        }
    }
    
    func anyActionReducer() -> some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case let .anyAction(.isSearchBarEditing(isEditing)):
                Logger.debug("isEditing : \(isEditing)")
                state.isHideLatestSearch = isEditing
                state.isSearchSuccess = isEditing
                state.isOnSearchResult = !isEditing
                
            default:
                break
            }
            
            return .none
        }
    }
}

//MARK: - MockData
struct SearchMockData : Equatable, Identifiable {
    let id : UUID = UUID()
    var placeName : String
    var address : String
    var latitude : Double
    var longitude : Double
}

