//
//  StudyMapFeature.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/15/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct StudyMapFeature {
    @ObservableState
    struct State : Equatable {
        let id = UUID()
        var filterCase : [MapFilterCase] =  MapFilterCase.getAllFilters()
        
        var isSpecificLocation : Bool = false
        var specificLocation : SearchMockData = .init()
    }
    
    enum Action : BindableAction {
        case binding(BindingAction<State>)
        case viewTransition(ViewTransition)
        case networkResponse(NetworkReponse)
        case buttonTapped(ButtonTapped)
        case mapProvider(MapProvider)
    }
    
    enum ViewTransition {
        case onAppear
        case goToSearch
    }
    
    enum NetworkReponse {
        
    }
    
    enum ButtonTapped {
        case search
    }
    
    enum MapProvider {
        case registerPublisher
        case onMoveToSpecificLocation(SearchMockData)
    }

    @Dependency(\.networkManager) var networkManager
    @Dependency(\.naverMapManager) var naverMapManager
    
    var body : some ReducerOf<Self> {
        
        BindingReducer()
        
        viewtransitionReducer()
        buttonTappedReducer()
        mapProviderReducer()
    }
}

extension StudyMapFeature {
    func viewtransitionReducer() -> some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewTransition(.onAppear):
                Logger.debug("StudyMap - onAppear")
                return .run { send in
                    await send(.mapProvider(.registerPublisher))
                }
                
            default:
                break
            }
            
            return .none
        }
    }
    
    func buttonTappedReducer() -> some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .buttonTapped(.search):
                return .run { send in
                    await send(.viewTransition(.goToSearch))
                }
            default:
                break
            }
            
            return .none
        }
    }
    
    func mapProviderReducer() -> some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .mapProvider(.registerPublisher):
                return .merge(registerPublisher())
                
            case let .mapProvider(.onMoveToSpecificLocation(location)):
                Logger.debug("studyMapFeature onMoveToSpecificLocation \(location) ✅✅✅✅")
                state.isSpecificLocation = true
                state.specificLocation = location
                
            default:
                break
            }
            
            return .none
        }
    }
    
    private func registerPublisher() -> [Effect<StudyMapFeature.Action>] {
        var effects : [Effect<StudyMapFeature.Action>] = .init()
        
        effects.append(Effect<StudyMapFeature.Action>
            .publisher {
                naverMapManager.onMoveToSpecificLocation
                    .map { location in
                        Action.mapProvider(.onMoveToSpecificLocation(location))
                    }
            }
        )
        
        return effects
    }
}
