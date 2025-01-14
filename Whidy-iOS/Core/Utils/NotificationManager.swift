//
//  NotificationManager.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 12/31/24.
//

import SwiftUI
import UserNotifications

final class NotificationManager : ObservableObject {
    static let shared = NotificationManager()
    private init() { }
    
    func requestAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                Logger.info("Notification authorization error: \(error)")
            } else if granted {
                Logger.info("Notification permission granted")
            }
        }
    }
    
    
    func scheduleNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        // Trigger after 1 second
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
}
