//
//  FavoriteQuotes.swift
//  StoicQuotes
//
//  Created by Julian Rakow on 17.10.23.
//

import SwiftUI

struct FavoriteQuotesView: View {
    
    @EnvironmentObject var favoriteQuotes: UserDataStore
    
    var body: some View {
        Text("Favorite quotes")
            .font(.largeTitle)
        VStack {
            if favoriteQuotes.quoteItems.isEmpty {
                Text("No quotes added yet!")
            } else {
                List {
                    ForEach(favoriteQuotes.quoteItems) { quoteItem in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(quoteItem.quote)
                                .font(.title)
                            Text(quoteItem.author)
                                .italic()
                        }
                        .padding()
                    }
//                    .onDelete(perform: favoriteQuotes.deleteItem)
                    .onDelete { indexSet in
                        favoriteQuotes.quoteItems.remove(atOffsets: indexSet)
                    }
                }
            }
        }
    }
}

#Preview {
    FavoriteQuotesView()
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
