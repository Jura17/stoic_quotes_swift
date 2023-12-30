//
//  StoicQuotesApp.swift
//  StoicQuotes
//
//  Created by Julian Rakow on 11.10.23.
//

import SwiftUI

@main
struct StoicQuotesApp: App {
    
//    @AppStorage("favoriteQuotes") private var favoriteQuotesData: Data = Data()
    
    // Create appStorage obj favoriteQuotes and fill environment obj with the data
    // If empty create a new FavoriteQuotes()
//    var favoriteQuotes = FavoriteQuotes()
    @StateObject var userData = UserDataStore()
    @StateObject private var lnManager = LocalNotificationManager()
    
    var body: some Scene {
        WindowGroup {
            QuoteFeed()
                .environmentObject(userData)
                .environmentObject(lnManager)
            //                .preferredColorScheme(.light)
        }
    }
}

