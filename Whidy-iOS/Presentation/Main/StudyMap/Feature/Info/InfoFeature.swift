//
//  InfoFeature.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 2/3/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct InfoFeautre {
    @ObservableState
    struct State : Equatable {
        let id = UUID()
        var currentPlace : Place = .init()
        var currentCafe : Cafe = .init()
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
    }
    
    enum NetworkReponse {
        case cafe(Result<Cafe, APIError>)
    }
    
    enum ButtonTapped {
        
    }
  

    enum AnyAction {

    }
    
    @Dependency(\.networkManager) var networkManager
    
    var body : some ReducerOf<Self> {
        
        BindingReducer()
        
        viewTransition()
        networkResponseReducer()
    }
}

extension InfoFeautre {
    func viewTransition() -> some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewTransition(.onAppear):
                Logger.debug("InfoView onAppear 🤔")
                
                return .run { [id = state.currentPlace.id] send in
                    await send(.networkResponse(.cafe(
                        networkManager.getGeneralCafePlace(id: id)
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
            case let .networkResponse(.cafe(.success(cafe))):
                Logger.debug("cafe success 🤔 \(cafe)")
                state.currentCafe = cafe
                
            case let .networkResponse(.cafe(.failure(error))):
                let errorType = APIError.networkErrorType(error: error)
                Logger.error("\(error) ->>🤔 \(errorType), \(error.errorMessage)")
                
            default:
                break
            }
            
            return .none
        }
    }
}
