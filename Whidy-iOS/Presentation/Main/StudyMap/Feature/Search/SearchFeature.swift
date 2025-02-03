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
        var searchResult : [Place] = .init()
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
        case goToResultLocation(Place)
    }
    
    enum NetworkReponse {
        case place(Result<[Place], APIError>)
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
        networkResponseReducer()
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
                //TODO: - 검색어 없다고 toast나 popup필요
                Logger.debug("userInputSubmit - \(state.userInput)")
                if state.userInput.isEmpty { return .none }
                
                //TODO: - 에러 메세지 필요
                let myLocation = naverMapManager.getMyLocation()
                guard let lat = myLocation.latitude , let lng = myLocation.longitude else { return .none }
                let condition = PlaceSearchCondition(centerLatitude: lat, centerLongitude: lng, radius: 99999, keyword: state.userInput) /// 검색이 radius 제한 해제
                                
                state.isOnSearchResult = true
                state.isSearchSuccess = true
                
                return .run { send in
                    await send(.networkResponse(.place(
                        networkManager.getPlace(condition: condition)
                    )))
                }
                
            default:
                break
            }
            
            return .none
        }
    }
    
    func networkResponseReducer() -> some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .networkResponse(.place(.success(placeList))):
                Logger.debug(placeList)
                state.searchResult = placeList
                
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
                state.searchResult = .init()
                
            default:
                break
            }
            
            return .none
        }
    }
}
