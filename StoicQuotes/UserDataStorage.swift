//
//  FavoriteQuotes.swift
//  StoicQuotes
//
//  Created by Julian Rakow on 17.10.23.
//

import SwiftUI

//final class FavoriteQuotesStore: ObservableObject {
//    @Published var quoteItems: [Quote] = []
//    
//    func add(_ quote: Quote) {
//        quoteItems.append(quote)
//    }
//    
//    func deleteItem(at offsets: IndexSet) {
//        quoteItems.remove(atOffsets: offsets)
//    }
//    
//    // maybe put appStorage methods here to retrieve and save favorites
//}

final class UserDataStorage: ObservableObject {
    
    @Published var favoriteQuotes: [Quote] = []
    @AppStorage("favoriteQuotes") var favoriteQuotesData: Data = Data()
    @AppStorage("scheduleRequested") var scheduleRequested = false
    @AppStorage("isDarkMode") var isDarkMode = false
    @AppStorage("firstLaunch") var firstLaunch = true
    
    init() {
        loadFavoriteQuotes()
    }
    
    func loadFavoriteQuotes() {
        if let decoded = try? JSONDecoder().decode([Quote].self, from: favoriteQuotesData) {
            favoriteQuotes = decoded
        }
    }
    
    func saveFavoriteQuotes() {
        if let data = try? JSONEncoder().encode(favoriteQuotes) {
            favoriteQuotesData = data
        }
    }
    
    func toggleFavorite(currentQuote: String, currentAuthor: String) {
        if let index = checkIfFavorite(currentAuthor: currentAuthor, currentQuote: currentQuote) {
            favoriteQuotes.remove(at: index)
        } else {
            let newQuote = Quote(id: UUID(), author: currentAuthor, quote: currentQuote)
            favoriteQuotes.append(newQuote)
        }
        saveFavoriteQuotes()
    }
    
    func checkIfFavorite(currentAuthor: String, currentQuote: String) -> Int? {
        return favoriteQuotes.firstIndex(where: { $0.author == currentAuthor && $0.quote == currentQuote })
    }
    
//    func add(_ quote: Quote) {
//        quoteItems.append(quote)
//    }
//    
    func deleteItem(at offsets: IndexSet) {
        favoriteQuotes.remove(atOffsets: offsets)
        saveFavoriteQuotes()
    }
    
}

// makes it possible to save a value of type date to appStorage
extension Date: RawRepresentable {
    public var rawValue: String {
        self.timeIntervalSinceReferenceDate.description
    }
    
    public init?(rawValue: String) {
        self = Date(timeIntervalSinceReferenceDate: Double(rawValue) ?? 0.0)
    }
}
