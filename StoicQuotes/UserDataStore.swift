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

final class UserDataStore: ObservableObject {
    
    @Published var quoteItems: [Quote] = []
    @AppStorage("favoriteQuotes") var favoriteQuotesData: Data = Data()
//    @AppStorage("notificationEnabled") var notificationsEnabled: Bool = false
    
    init() {
        loadFavoriteQuotes()
    }
    
    func loadFavoriteQuotes() {
        if let decoded = try? JSONDecoder().decode([Quote].self, from: favoriteQuotesData) {
            quoteItems = decoded
        }
    }
    
    func saveFavoriteQuotes() {
        if let data = try? JSONEncoder().encode(quoteItems) {
            favoriteQuotesData = data
        }
    }
    
    func toggleFavorite(currentQuote: String, currentAuthor: String) {
        if let index = checkIfFavorite(currentQuote: currentQuote, currentAuthor: currentAuthor) {
            quoteItems.remove(at: index)
        } else {
            let newQuote = Quote(id: UUID(), author: currentAuthor, quote: currentQuote)
            quoteItems.append(newQuote)
        }
        saveFavoriteQuotes()
    }
    
    func checkIfFavorite(currentQuote: String, currentAuthor: String) -> Int? {
        return quoteItems.firstIndex(where: { $0.quote == currentQuote && $0.author == currentAuthor })
    }
    
//    func add(_ quote: Quote) {
//        quoteItems.append(quote)
//    }
//    
//    func deleteItem(at offsets: IndexSet) {
//        quoteItems.remove(atOffsets: offsets)
//    }
    
}
