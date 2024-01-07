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
    @StateObject var userDataStorage = UserDataStorage()
    @StateObject var lnManager = LocalNotificationManager()
    @StateObject var viewModel = QuoteFeedViewModel()
    
    var body: some Scene {
        WindowGroup {
            QuoteFeed()
                .environmentObject(userDataStorage)
                .environmentObject(lnManager)
                .environmentObject(viewModel)
            //                .preferredColorScheme(.light)
        }
    }
}

