//
//  NotificationManager.swift
//  StoicQuotes
//
//  Created by Julian Rakow on 29.12.23.
//

import SwiftUI
import NotificationCenter

@MainActor
class LocalNotificationManager: ObservableObject {
    
    let notificationCenter = UNUserNotificationCenter.current()
    @Published var isGranted = false
    @Published var pendingRequests: [UNNotificationRequest] = []
    @AppStorage("scheduledTime") var scheduledTime = Date()
    
    func requestAuthorization() async throws {
        try await notificationCenter.requestAuthorization(options: [.sound, .badge, .alert])
        await getCurrentSettings()
    }
    
    func getCurrentSettings() async {
        let currentSettings = await notificationCenter.notificationSettings()
        isGranted = (currentSettings.authorizationStatus == .authorized)
    }
    
    func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                Task {
                    await UIApplication.shared.open(url)
                }
            }
        }
    }
    
    func getPendingRequests() async -> [UNNotificationRequest] {
        print("pending requests:")
        return await notificationCenter.pendingNotificationRequests()
    }
    
//    func schedule(localNotification: LocalNotification) async {
//        let content = UNMutableNotificationContent()
//        content.title = localNotification.title
//        content.body = localNotification.body
//        content.sound = .default
//        
//        guard let dateComponents = localNotification.dateComponents else { return }
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: localNotification.repeats)
//        let request = UNNotificationRequest(identifier: localNotification.identifier, content: content, trigger: trigger)
//        try? await notificationCenter.add(request)
//    }
    
    func scheduleNotification(author: String, quote: String) {
        Task {
            let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: scheduledTime)
            let localNotification = LocalNotification(identifier: UUID().uuidString, title: author, body: quote, dateComponents: dateComponents, repeats: true)
//            await schedule(localNotification: localNotification)
            
            let content = UNMutableNotificationContent()
            content.title = localNotification.title
            content.body = localNotification.body
            content.sound = .default
            
            guard let dateComponents = localNotification.dateComponents else { return }
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: localNotification.repeats)
            let request = UNNotificationRequest(identifier: localNotification.identifier, content: content, trigger: trigger)
            try? await notificationCenter.add(request)
        }
    }
    
}
