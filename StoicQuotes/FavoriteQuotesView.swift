//
//  FavoriteQuotes.swift
//  StoicQuotes
//
//  Created by Julian Rakow on 17.10.23.
//

import SwiftUI

struct FavoriteQuotesView: View {
    
    @EnvironmentObject var userDataStorage: UserDataStorage
    
    var body: some View {
        Text("Favorite quotes")
            .font(.largeTitle)
        VStack {
            if userDataStorage.favoriteQuotes.isEmpty {
                Text("No quotes added yet!")
            } else {
                List {
                    ForEach(userDataStorage.favoriteQuotes) { quoteItem in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(quoteItem.quote)
                                .font(.title)
                            Text(quoteItem.author)
                                .italic()
                        }
                        .padding()
                    }
                    .onDelete(perform: userDataStorage.deleteItem)
//                    .onDelete { indexSet in
//                        favoriteQuotes.favoriteQuotes.remove(atOffsets: indexSet)
//                    }
                }
            }
        }
    }
}

#Preview {
    FavoriteQuotesView()
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
