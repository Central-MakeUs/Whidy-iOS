//
//  UserDefaults+Extension.swift
//  z-car
//
//  Created by Namuplanet on 8/27/24.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    enum UserDefaultsKeys : String {
        // Auto Login
        case autoLogin
        case autoLoginConfirm
        
        // Authentication
        case bearerToken
        case joinType
        
        // Vehicle Info
        case vin
        case carNbr
        
        // Bluetooth Info
        case btName
        case btAddress
        case autoBleConnect
        
        // Session Info
        case session
        
        // Apple Login
        case appleIDEmail
        case appleIDName
        case appleIDUnique
        case appleIDAuthCode
        case appleClientSecret
        
        // Debug Mode
        case isSimulator
        case isTestServer
        
        static func isExclude(_ keys : String) -> Bool {
            if keys == UserDefaultsKeys.isSimulator.rawValue || keys == UserDefaultsKeys.isTestServer.rawValue {
                return true
            } else {
                return false
            }
        }
    }
    
    var autoLogin: DefaultsKey<Bool> { .init(UserDefaultsKeys.autoLogin.rawValue, defaultValue: false) }
    var autoLoginConfirm: DefaultsKey<Bool> { .init(UserDefaultsKeys.autoLoginConfirm.rawValue, defaultValue: false) }
    var bearerToken: DefaultsKey<String> { .init(UserDefaultsKeys.bearerToken.rawValue, defaultValue: "") }
    var joinType : DefaultsKey<String> { .init(UserDefaultsKeys.joinType.rawValue, defaultValue: "") }
    var vin: DefaultsKey<String> { .init(UserDefaultsKeys.vin.rawValue, defaultValue: "") }
    var carNbr: DefaultsKey<String> { .init(UserDefaultsKeys.carNbr.rawValue, defaultValue: "") }
    
    var btName: DefaultsKey<String> { .init(UserDefaultsKeys.btName.rawValue, defaultValue: "") }
    var btAddress: DefaultsKey<String> { .init(UserDefaultsKeys.btAddress.rawValue, defaultValue: "") }
    var autoBleConnet : DefaultsKey<Bool> { .init(UserDefaultsKeys.autoBleConnect.rawValue, defaultValue: false) }
    var session : DefaultsKey<MemberInfo?> { .init(UserDefaultsKeys.session.rawValue)}
    
    // appLogin
    var appleIDEmail: DefaultsKey<String> { .init(UserDefaultsKeys.appleIDEmail.rawValue, defaultValue: "") }
    var appleIDName: DefaultsKey<String> { .init(UserDefaultsKeys.appleIDName.rawValue, defaultValue: "") }
    var appleIDUnique: DefaultsKey<String> { .init(UserDefaultsKeys.appleIDUnique.rawValue, defaultValue: "") }
    var appleIDAuthCode: DefaultsKey<String> { .init(UserDefaultsKeys.appleIDAuthCode.rawValue, defaultValue: "") }
    var appleClientSecret: DefaultsKey<String> { .init(UserDefaultsKeys.appleClientSecret.rawValue, defaultValue: "")}
    
    // Debug Mode
    var isSimulator: DefaultsKey<Bool> { .init(UserDefaultsKeys.isSimulator.rawValue, defaultValue: false) }
    var isTestServer: DefaultsKey<Bool> { .init(UserDefaultsKeys.isTestServer.rawValue, defaultValue: false) }
}

extension UserDefaults {
    static func clearUserDefaults() {
        DispatchQueue.global(qos: .background).async {
            let userDefaults = UserDefaults.standard
            let allKeys = userDefaults.dictionaryRepresentation().keys
            
            for key in allKeys {
                if !DefaultsKeys.UserDefaultsKeys.isExclude(key) { // 제외할 키 리스트에 없는 경우에만 삭제
                    userDefaults.removeObject(forKey: key)
                }
            }
            
            // 변경 사항 즉시 저장
            userDefaults.synchronize()
        }
    }}
