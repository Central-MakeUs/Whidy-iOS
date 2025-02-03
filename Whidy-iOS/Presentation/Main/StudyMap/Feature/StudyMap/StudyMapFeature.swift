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
        var info = InfoFeautre.State() /// child View
        var filterCase : [MapFilterCase] =  MapFilterCase.getAllFilters()
        var placeList : [Place] = .init()
        var placeSpecific : Place = .init()
        
        var isSpecificLocation : Bool = false
        var isShowInfoDetial : Bool = false
    }
    
    enum Action : BindableAction {
        case binding(BindingAction<State>)
        case info(InfoFeautre.Action)
        case viewTransition(ViewTransition)
        case networkResponse(NetworkReponse)
        case buttonTapped(ButtonTapped)
        case mapProvider(MapProvider)
    }
    
    enum ViewTransition {
        case onAppear
        case goToSearch
        case returnToSearch
        case goToInfoDetail
    }
    
    enum NetworkReponse {
        case place(Result<[Place], APIError>)
    }
    
    enum ButtonTapped {
        case tag(MapFilterCase)
        case search
        case specificLocationToSearch
        case specificLocationCancel
    }
    
    enum MapProvider {
        case registerPublisher
        case onMoveToSpecificLocation(Place)
    }
    
    @Dependency(\.networkManager) var networkManager
    @Dependency(\.naverMapManager) var naverMapManager
    
    var body : some ReducerOf<Self> {
        
        BindingReducer()
        
        Scope(state: \.info, action: \.info) {
            InfoFeautre()
        }
        
        viewtransitionReducer()
        networkResponseReducer()
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
            case let .buttonTapped(.tag(placeType)):
                Logger.debug("placeType: \(placeType), myLocation - \(naverMapManager.getMyLocation())")
                let myLocation = naverMapManager.getMyLocation()
                guard let lat = myLocation.latitude , let lng = myLocation.longitude else { return .none }
                let condition = PlaceSearchCondition(placeType: [placeType.placeType], centerLatitude: lat, centerLongitude: lng, radius: placeType.placeRadius)
                
                Logger.debug("condition: \(condition)")
                
                return .run { send in
                    await send(.networkResponse(.place(
                        networkManager.getPlace(condition: condition))))
                }
                
            case .buttonTapped(.search):
                return .run { send in
                    await send(.viewTransition(.goToSearch))
                }
                
            case .buttonTapped(.specificLocationToSearch):
                Logger.debug("specificLocationToSearch")
                
                return .run { send in
                    await send(.viewTransition(.returnToSearch))
                }
                
            case .buttonTapped(.specificLocationCancel):
                state.isSpecificLocation = false
                state.isShowInfoDetial = false
                state.placeSpecific = .init()
                naverMapManager.cancelSpecificLocation()
                
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
                state.placeList = placeList
                
            case let .networkResponse(.place(.failure(error))):
                let errorType = APIError.networkErrorType(error: error)
                Logger.error("\(error) ->>🤔 \(errorType), \(error.errorMessage)")
                
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
                state.info.currentPlace = location
                state.isSpecificLocation = true
                state.isShowInfoDetial = true
                state.placeSpecific = location
                
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
