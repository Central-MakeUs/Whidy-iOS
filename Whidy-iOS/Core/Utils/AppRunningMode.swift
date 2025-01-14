//
//  AppRunningMode.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 11/22/24.
//

import Foundation
import SwiftyUserDefaults

final class AppRunningMode {
    
    enum RunningMode {
        case productWithActual  /// isTestServer = false, isSimulator = false
        case productWithSimulator /// isTestSever = false, isSimulator = true
        case testWithActual /// isTestServer = true, isSimulator = false
        case testWithSimulator /// isTestServer = true, isSimulator = true
    }
    
    private static var currentMode: RunningMode?
    
    /// 앱 실행 모드 설정
    ///
    /// - Parameter mode: 운영/테스트 및 실차량/시뮬레이터 설정
    static func mode(_ mode : RunningMode) {
        currentMode = mode
        
        switch mode {
        case .productWithActual:
            Defaults.isTestServer = false
            Defaults.isSimulator = false
            Logger.info("❗️❗️❗️ App Running Mode - Product With Actual ❗️❗️❗️")
            
        case .productWithSimulator:
            Defaults.isTestServer = false
            Defaults.isSimulator = true
            Logger.info("❗️❗️❗️ App Running Mode - Product With Simulator ❗️❗️❗️")
            
        case .testWithActual:
            Defaults.isTestServer = true
            Defaults.isSimulator = false
            Logger.info("❗️❗️❗️ App Running Mode - Test With Actual ❗️❗️❗️")
            
        case .testWithSimulator:
            Defaults.isTestServer = true
            Defaults.isSimulator = true
            Logger.info("❗️❗️❗️ App Running Mode - Test With Simulator ❗️❗️❗️")
        }
    }
    
    /// 현재 모드가 시뮬레이터인지 확인하는 연산 프로퍼티
    static var isSimulatorMode: Bool {
        guard let mode = currentMode else {
            Logger.warning("AppRunningMode is not set. Defaulting to false.")
            return false
        }
        switch mode {
        case .productWithSimulator, .testWithSimulator:
            return true
        default:
            return false
        }
    }
}
