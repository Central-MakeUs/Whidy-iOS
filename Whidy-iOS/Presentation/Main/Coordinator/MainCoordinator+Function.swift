//
//  MainCoordinator+Function.swift
//  z-car
//
//  Created by Namuplanet on 10/23/24.
//

import Foundation
import ComposableArchitecture
import TCACoordinators
import SwiftyUserDefaults

extension MainCoordinator {
    func tabSelectedReducer() -> some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .tabSelected(tab):
                state.selectedTab = tab
            default:
                break
            }
            
            return .none
        }
    }
    
//    func viewTransitionReducer() -> some ReducerOf<Self> {
//        Reduce { state, action in
//            switch action {
//            case .viewTransition(.onAppear):
//                /// memberSession init
//                state.memberSession = .init(
//                    isBleConnect: false,
//                    currentVin: Defaults.vin,
//                    currentNbr: Defaults.carNbr
//                )
//                
//                obd2Collector.initData()
//                state.isOBD2CollectInit = true
//                
//                return .run { send in
//                    await send(.provider(.registerPublisher))
//                    try await Task.sleep(for: .seconds(0.2))
//                    await send(.networkResponse(.appVersionCheck(
//                        appstoreCheck.latestVersion()
//                    )))
//                    
//                    if Defaults.autoBleConnet {
//                        await send(.home(.router(.routeAction(id: .home, action: .home(.viewTransition(.OBDConnectLoadingOn))))))
//                    }
//                }
//            default:
//                break
//            }
//            
//            return .none
//        }
//    }
//    
//    func childActionReducer() -> some ReducerOf<Self> {
//        Reduce { state, action in
//            switch action {
//            case .home(.router(.routeAction(id: .home, action: .home(.viewTransition(.loadingOn))))), .home(.router(.routeAction(id: .carRegister, action: .carRegister(.viewTransition(.loadingOn))))), .carCenter(.router(.routeAction(id: .carRegister, action: .carRegister(.viewTransition(.loadingOn))))), .carCenter(.router(.routeAction(id: .carIndiv, action: .carIndiv(.viewTransition(.loadingOn))))), .carCenter(.router(.routeAction(id: .carCenter, action: .carCenter(.viewTransition(.loadingOn))))), .driver(.router(.routeAction(id: .driver, action: .driver(.viewTransition(.loadingOn))))), .ecoDrive(.router(.routeAction(id: .ecoDrive, action: .ecoDrive(.viewTransition(.loadingOn))))):
//                state.showLoadingIndicator = true
//                
//            case .home(.router(.routeAction(id: .home, action: .home(.viewTransition(.loadingOff))))), .home(.router(.routeAction(id: .home, action: .home(.provider(.onConnectEcuProperty))))), .home(.router(.routeAction(id: .carRegister, action: .carRegister(.viewTransition(.loadingOff))))), .carCenter(.router(.routeAction(id: .carRegister, action: .carRegister(.viewTransition(.loadingOff))))), .home(.router(.routeAction(id: .carRegister, action: .carRegister(.anyAction(.popupHandling(_)))))), .carCenter(.router(.routeAction(id: .carCenter, action: .carCenter(.provider(.onConnectEcuProperty))))), .carCenter(.router(.routeAction(id: .carIndiv, action: .carIndiv(.viewTransition(.loadingOff))))), .carCenter(.router(.routeAction(id: .carCenter, action: .carCenter(.viewTransition(.loadingOff))))), .driver(.router(.routeAction(id: .driver, action: .driver(.viewTransition(.loadingOff))))), .ecoDrive(.router(.routeAction(id: .ecoDrive, action: .ecoDrive(.viewTransition(.loadingOff))))):
//                state.showLoadingIndicator = false
//                
//                /// 차량 미등록의 경우, CarCenter Tab 전환
//            case .home(.router(.routeAction(id: .home, action: .home(.viewTransition(.goToCarCenter))))), .ecoDrive(.router(.routeAction(id: .ecoDrive, action: .ecoDrive(.viewTransition(.goToCarCenter))))):
//                
//                return .send(.tabSelected(.carCenter))
//                
//                /// 차량 선택시, 이전 차량데이터 삭제
//            case .carCenter(.router(.routeAction(id: .carCenter, action: .carCenter(.viewTransition(.carSelected))))):
//                obd2Collector.resetData()
//                
//                var effect = resetIsInit()
//                effect.append(.send(.ecoDrive(.router(.routeAction(id: .ecoDrive, action: .ecoDrive(.provider(.resetEcoDriverItemWithAll)))))))
//                
//                return .merge(effect)
//            default:
//                break
//            }
//            
//            return .none
//        }
//    }
//    
//    func networkResponseReducer() -> some ReducerOf<Self> {
//        Reduce { state, action in
//            switch action {
//            case .networkResponse(.onInsertCarDriverEventProperty(.success(_))):
//                Logger.info("InsertCarDriverEventRequest - success")
//                
//            case let .networkResponse(.onInsertCarDriverEventProperty(.failure(error))):
//                Logger.error("InsertCarDriverEventRequest - \(error)")
//                
//            case let .networkResponse(.appVersionCheck(latestVersion)):
//                guard let latestVersion, let currentVersion = appstoreCheck.currentVersion() else { return .none }
//                Logger.info("App Current Version : \(currentVersion), App Latest Version: \(latestVersion)")
//                
//                state.isAppVersionOld = appstoreCheck.isVersionOld(current: currentVersion, latest: latestVersion)
//                
//                /// App이 latest가 아닌 경우, OBD2 연결 X
//                if !state.isAppVersionOld {
//                    return .run { send in
//                        await send(.provider(.onAutoConnectDevice))
//                    }
//                }
//                
//            default:
//                break
//            }
//            
//            return .none
//        }
//    }
//    
//    func anyActionReducer() -> some ReducerOf<Self> {
//        Reduce { state, action in
//            switch action {
//            case let .anyAction(.popupHandler(popup)):
//                state.popupPresent = popup
//                
//            case .anyAction(.liveActivitiesOn):
//                liveAtivitiesManager.onLiveActivity()
//                
//            case .anyAction(.liveActivitiesOff):
//                liveAtivitiesManager.offLiveActivity()
//                
//            default:
//                break
//            }
//            
//            return .none
//        }
//    }
    
}
