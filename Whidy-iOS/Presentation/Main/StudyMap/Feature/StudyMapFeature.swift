//
//  StudyMapFeature.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/15/25.
//

import Foundation
import ComposableArchitecture

enum MapFilterCase : CaseIterable, Hashable, Identifiable {
    case free
    case franchise
    case study
    case library
    case personal
    
    var caseTitle : String {
        switch self {
        case .free: return "무료공간"
        case .franchise: return "프랜차이즈 카페"
        case .study: return "스터디 카페"
        case .library: return "도서관"
        case .personal: return "개인 카페"
        }
    }
    
    var id: Self { self }
    
    static func getAllFilters() -> [MapFilterCase] {
        return MapFilterCase.allCases
    }
    
    static var allTitles: [String] {
        return MapFilterCase.allCases.map { $0.caseTitle }
    }
}

@Reducer
struct StudyMapFeature {
    @ObservableState
    struct State : Equatable {
        let id = UUID()
        var filterCase : [MapFilterCase] =  MapFilterCase.getAllFilters()
    }
    
    enum Action : BindableAction {
        case binding(BindingAction<State>)
        case networkResponse(NetworkReponse)
        case buttonTapped(ButtonTapped)
        case viewTransition(ViewTransition)
        case anyAction(AnyAction)
    }
    
    enum NetworkReponse {
        
    }
    
    enum ButtonTapped {
        
    }
    
    enum ViewTransition {
        case onAppear
    }

    enum AnyAction {

    }
    
    @Dependency(\.networkManager) var networkManager
    
    var body : some ReducerOf<Self> {
        
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            
                
            default :
                break
            }
            return .none
        }
    }
}

