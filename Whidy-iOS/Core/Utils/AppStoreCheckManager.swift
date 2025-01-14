//
//  AppStoreCheckManager.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 11/18/24.
//

import SwiftUI
import ComposableArchitecture

final class AppStoreCheckManager {
    private let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    private let appId = "6504797351"
    lazy var appStoreOpenUrlString = "https://apps.apple.com/app/\(appId)"  // App Store 링크
    
    func currentVersion() -> String? {
        return appVersion
    }
    
    func latestVersion() async -> String? {
        guard let url = URL(string: "https://itunes.apple.com/lookup?id=\(appId)&country=kr") else {
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
               let results = json["results"] as? [[String: Any]],
               let appStoreVersion = results.first?["version"] as? String {
                return appStoreVersion
            }
        } catch {
            Logger.error("Error fetching app version: \(error)")
        }
        
        return nil
    }
        
    func isVersionOld(current : String, latest : String) -> Bool {
        let currentSplit = splitVersion(current)
        let latestSplit = splitVersion(latest)
        
        /// debug version mismatch
        if currentSplit[2] < latestSplit[2] || currentSplit[1] < latestSplit[1] || currentSplit[0] < latestSplit[0] {
            return true
        } else {
            Logger.info("App Current Version is Latest!")
            return false
        }
    }
    
    
    func openAppStore() {
        guard let url = URL(string: appStoreOpenUrlString) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    private func splitVersion(_ version : String) -> [String] {
        let splitVersion = version.split(separator: ".").map { String($0) }
        
        return splitVersion
    }
}

private enum AppStoreCheckManagerKey: DependencyKey {
    static var liveValue: AppStoreCheckManager = AppStoreCheckManager()
}

extension DependencyValues {
    var appStoreCheck: AppStoreCheckManager {
        get { self[AppStoreCheckManagerKey.self] }
        set { self[AppStoreCheckManagerKey.self] = newValue }
    }
}
