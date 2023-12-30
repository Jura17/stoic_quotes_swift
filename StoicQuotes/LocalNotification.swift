//
//  LocalNotification.swift
//  StoicQuotes
//
//  Created by Julian Rakow on 29.12.23.
//

import Foundation

struct LocalNotification {
    
    var identifier: String
    var title: String
    var body: String
    var dateComponents: DateComponents?
    var repeats = true
    // repeats is always true because it's supposed to be a daily notification and the user has no option other than scheduling the notification for a specific time
    // Leaving it in here as a property for future changes
}
