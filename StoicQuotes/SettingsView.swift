//
//  SettingsView.swift
//  StoicQuotes
//
//  Created by Julian Rakow on 11.10.23.
//

import SwiftUI

@MainActor
struct SettingsView: View {
    @EnvironmentObject var userData: UserDataStore
    @EnvironmentObject var lnManager: LocalNotificationManager
    @Environment(\.scenePhase) var scenePhase
    @State private var scheduleDate = Date()
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
                                    DatePicker("Daily Notifications", selection: $scheduleDate, displayedComponents: .hourAndMinute)
                                    Button("Schedule notification") {
                                        Task {
                                            let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: scheduleDate)
                                            let localNotification = LocalNotification(identifier: UUID().uuidString, title: "Test title", body: "Test body", dateComponents: dateComponents, repeats: true)
                                            await lnManager.schedule(localNotification: localNotification)
                                        }
                                    }
                                    .buttonStyle(.bordered)
                                }
                            } else {
                                Button("Enable Notifications") {
                                    lnManager.openSettings()
                                }.buttonStyle(.borderedProminent)
                            }
//                            Toggle("Enable daily Notifications", isOn: $lnManager.isGranted)
                            // Toggle logic goes into SettingsViewModel
                            
                        }
                    }
                    .task {
                        try? await lnManager.requestAuthorization()
                    }
                    .onChange(of: scenePhase) {
                        if scenePhase == .active {
                            Task {
                                await lnManager.getCurrentSettings()
                            }
                        }
                    }
                }
                Spacer()
            }
        }
        .padding(30)
    }
}
