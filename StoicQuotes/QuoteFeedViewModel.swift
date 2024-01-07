//
//  QuoteFeedViewModel.swift
//  StoicQuotes
//
//  Created by Julian Rakow on 13.10.23.
//

import Foundation

// needs to be marked @MainActor because data fetches on background (using async/await) thread but updating the UI always happens on MainThread
@MainActor
final class QuoteFeedViewModel: ObservableObject {
    @Published var author: String = ""
    @Published var quote: String = ""
    @Published var isLoading = false
    
    func fetchQuote() {
        isLoading = true
        guard let url = URL(string: "https://stoic.tekloon.net/stoic-quote") else {
            print("There was a problem with the URL")
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
}
