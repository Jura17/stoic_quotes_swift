//
//  QuoteFeedViewModel.swift
//  StoicQuotes
//
//  Created by Julian Rakow on 13.10.23.
//

import SwiftUI

// needs to be marked @MainActor because data fetches on background (using async/await) thread but updating the UI always happens on MainThread
@MainActor
final class QuoteFeedViewModel: ObservableObject {
    @Published var author: String = ""
    @Published var quote: String = ""
    @Published var isLoading = false
    
    func fetchQuote() {
        isLoading = true
        guard let url = URL(string: "https://stoic.tekloon.net/stoic-quote") else {
            print("The was a problem with the URL")
            return
        }
        Task {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try? JSONDecoder().decode(Quote.self, from: data)
            author = decodedResponse?.author ?? ""
            quote = decodedResponse?.quote ?? ""
            isLoading = false
        }
    }
    
//    @MainActor
//    func addNotifications() {
//        let center = UNUserNotificationCenter.current()
//        
//        let addRequest = {
//            let content = UNMutableNotificationContent()
//            self.fetchQuote()
//            content.title = self.author
//            content.subtitle = self.quote
//            content.sound = UNNotificationSound.default
//            
//            var dateComponents = DateComponents()
//            dateComponents.hour = 9
////            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: false)
//            
//            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//            center.add(request)
//        }
//        
//        center.getNotificationSettings { settings in
//            if settings.authorizationStatus == .authorized {
//                addRequest()
//            } else {
//                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
//                    if success {
//                        addRequest()
//                    } else {
//                        print("D'oh")
//                    }
//                }
//            }
//        }
//    }
}
