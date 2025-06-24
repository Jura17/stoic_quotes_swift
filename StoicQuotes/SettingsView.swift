//
//  SettingsView.swift
//  StoicQuotes
//
//  Created by Julian Rakow on 11.10.23.
//

import SwiftUI

@MainActor
struct SettingsView: View {
    
    @EnvironmentObject var lnManager: LocalNotificationManager
    @EnvironmentObject var userDataStorage: UserDataStorage
    @EnvironmentObject var viewModel: QuoteFeedViewModel
    @Environment(\.scenePhase) var scenePhase
    
    var quoteFeedVM: QuoteFeedViewModel
    // instead of a passing the QuoteFeedVM to the settings, we probably need to reference the state of notificationsEnabled on the home screen because that's what the user sees if they click on a notification. Also we might be able to avoid the main thread problem because the QuoteFeedVM already acts as a Main actor. So the addNotification func should probably be on the QuoteFeedVM
    
    var body: some View {
        VStack() {
            HStack {
                Spacer()
                Text("Settings")
                    .font(.largeTitle)
                Spacer()
            }
            Spacer()
            VStack {
                Spacer()
                Section {
                    Text("Settings")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack {
                        Image(systemName: "quote.bubble.fill")
                        Button {
                            
                        } label: {
                            NavigationLink(destination: FavoriteQuotesView(), label: {
                                Text("My favorite quotes")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.title)
                                    .tint(.white)
                            })
                        }
                    }
                    HStack {
                        Image(systemName: "bubble.left.fill")
                        VStack {
                            if lnManager.isGranted {
                                GroupBox {
                                    DatePicker("Daily Notifications", selection: $lnManager.scheduledTime, displayedComponents: .hourAndMinute)
                                        .onChange(of: lnManager.scheduledTime) {
                                            if userDataStorage.scheduleRequested {
                                                lnManager.scheduleNotification(author: viewModel.author, quote: viewModel.quote)
                                                print("requested")
                                            } else {
                                                print("time changed but no request")
                                            }
                                        }
                                    
                                    Toggle("Schedule daily Notifications", isOn: $userDataStorage.scheduleRequested)
                                        .padding()
                                        .onChange(of: userDataStorage.scheduleRequested) {
                                            if userDataStorage.scheduleRequested {
                                                lnManager.scheduleNotification(author: viewModel.author, quote: viewModel.quote)
                                                print("requested")
                                            } else {
                                                print("cancelled")
                                                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                                            }
                                        }
                                }
                            } else {
                                Button("Enable notifications in settings") {
                                    lnManager.openSettings()
                                }.buttonStyle(.borderedProminent)
                            }
                        }
                    }
                    .task {
                        try? await lnManager.requestAuthorization()
                    }
                    .onChange(of: scenePhase) {
                        if scenePhase == .active {
                            Task {
                                await print(lnManager.getPendingRequests())
                                await lnManager.getCurrentSettings()
                            }
                        }
                    }
                    .onAppear {
                        print("schedule requested: \(userDataStorage.scheduleRequested)")
                    }
                }
                Spacer()
            }
        }
        .padding(30)
    }
}
