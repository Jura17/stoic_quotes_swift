//
//  ContentView.swift
//  StoicQuotes
//
//  Created by Julian Rakow on 11.10.23.
//

import SwiftUI
import UserNotifications

struct QuoteFeed: View {
    
    @EnvironmentObject var userDataStorage: UserDataStorage
    @EnvironmentObject var lnManager: LocalNotificationManager
    @EnvironmentObject var viewModel: QuoteFeedViewModel
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    HStack(spacing: 20) {
                        Button {
                            userDataStorage.isDarkMode.toggle()
                        } label: {
                            if userDataStorage.isDarkMode {
                                Image(systemName: "moon.fill")
                                    .imageScale(.large)
                            } else {
                                Image(systemName: "moon")
                                    .imageScale(.large)
                            }
                        }
                        Text("Stoic Thoughts")
                            .font(.largeTitle)
                        NavigationLink(destination: SettingsView(quoteFeedVM: viewModel), label: {
                            if userDataStorage.isDarkMode {
                                Image(systemName: "gearshape.fill")
                                    .imageScale(.large)
                            } else {
                                Image(systemName: "gearshape")
                                    .imageScale(.large)
                            }
                        })
                    }
                    Spacer()
                    VStack {
                        if viewModel.isLoading {
                            LoadingView()
                        } else {
                            SwipeToFetchView(viewModel: viewModel)
                        }
                    }
                    Spacer()
                    HStack {
                        Button {
                            userDataStorage.toggleFavorite(currentQuote: viewModel.quote, currentAuthor: viewModel.author)
                        } label: {
                            if userDataStorage.checkIfFavorite(currentAuthor: viewModel.author, currentQuote: viewModel.quote) != nil {
                                Image(systemName: "heart.fill")
                                    .imageScale(.large)
                                    .padding(.trailing, 25)
                            } else {
                                Image(systemName: "heart")
                                    .imageScale(.large)
                                    .padding(.trailing, 25)
                            }
                        }
                        Button {
                            viewModel.fetchQuote()
                        } label: {
                            Text("Next quote")
                        }
                        .padding(.trailing, 25)
                        
                        ShareLink(item: "\(viewModel.quote)\n\n\(viewModel.author)") {
                            Label("", systemImage: "square.and.arrow.up")
                                .imageScale(.large)
                        }
                    }
                }
                .padding(30)
            }
            .onAppear {
                if userDataStorage.firstLaunch {
                    if colorScheme == .dark {
                        userDataStorage.isDarkMode = true
                    } else {
                        userDataStorage.isDarkMode = false
                    }
                    userDataStorage.firstLaunch = false
                }
                viewModel.fetchQuote()
                // here if the user tapped on a notification the quote that was fetched when tapping should override the quote that is stored as current quote using the payload that should (?) come with a notification
            }
//            .onChange(of: userData.notificationsEnabled) { _ in
//                viewModel.addNotifications()
//            }
//            .onReceive(NotificationCenter.default.publisher(for: ), perform: <#T##(Publisher.Output) -> Void#>)
        }
        .preferredColorScheme(userDataStorage.isDarkMode ? .dark : .light)
    }
 
//    func addOrRemoveFavorite() {
//        guard let indexFound = checkIfFavorite(currentQuote: quote, currentAuthor: author) else {
//            let newQuote = Quote(id: UUID(), author: author, quote: quote)
//            favoriteQuotes.add(newQuote)
//            return
//        }
//        let testIndexSet = IndexSet(integer: indexFound)
//        favoriteQuotes.deleteItem(at: testIndexSet)
//    }
    
}

