//
//  Enviroment.swift
//  EasyLab
//
//  Created by JinwooLee 2022/03/21.
//

import SwiftUI
import ComposableArchitecture

struct Environment {
    static var bundleVersion: String = {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }()
    
    static var buildVersion: String = {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
    }()
    
    static var appVersion: String = {
        switch Environment.currentPhase {
        case .real:
            return Environment.bundleVersion
        default:
            return "\(Environment.bundleVersion).\(Environment.buildVersion)"
        }
    }()
    
    static var bundleId: String = {
        Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String ?? ""
    }()
    
    static var displayName: String = {
        Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? ""
    }()
    
    static var clientInfo: String = {
        "\(Environment.displayName)/\(Environment.appVersion)/\(UIDevice.current.systemName)/\(UIDevice.current.systemVersion)"
    }()
    
    static var deviceModelName = {
        getDeviceModelName()
    }()
    
    static var osVersion: String = {
        UIDevice.current.systemVersion
    }()
    
    static var uuid: String = {
        UIDevice.current.identifierForVendor?.uuidString ?? ""
    }()
    
    static var currentPhase: BuildPhase = {
        #if DEBUG
        return .dev
        #else
        return .real
        #endif
    }()
    
    enum BuildPhase {
        case dev
        case real
    }
    
//    enum InMemoryKeys : String {
//        case memberSession = "memberSession"
//    }
    
    enum SharedInMemoryType<T> {
        case memberSession
        
        var keys : InMemoryKey<T> {
            switch self {
            case .memberSession:
                return .inMemory("memberSession")
            }
        }
    }
}

extension Environment {
    private static func getDeviceIdentifier() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }

    private static func getDeviceModelName() -> String {
        var modelName = ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] ?? ""
        if modelName.count > 0 {
            return modelName
        }
        
        // 디바이스
        let device = UIDevice.current
        let selName = "_\("deviceInfo")ForKey:"
        let selector = NSSelectorFromString(selName)
        if device.responds(to: selector) {
            modelName = String(describing: device.perform(selector, with: "marketing-name").takeRetainedValue())
        }
        return modelName
    }
}
