//
//  codeDump.swift
//  StoicQuotes
//
//  Created by Julian Rakow on 14.11.23.
//

//import SwiftUI
//
//struct SettingsView : View {
//    
//    //    @EnvironmentObject var favoriteQuotes: FavoriteQuotesStore
//    
//    @State private var notificationsEnabled = false
//    //    @State var notifcationTime = Date()
//    
//    var body: some View {
//        VStack() {
//            HStack {
//                Spacer()
//                Text("Settings")
//                    .font(.largeTitle)
//                Spacer()
//            }
//            Spacer()
//            VStack {
//                Spacer()
//                Section {
//                    Text("Settings")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    HStack {
//                        Image(systemName: "quote.bubble.fill")
//                        Button {
//                            
//                        } label: {
//                            NavigationLink(destination: FavoriteQuotesView(), label: {
//                                Text("My favorite quotes")
//                                    .frame(maxWidth: .infinity, alignment: .leading)
//                                    .font(.title)
//                                    .tint(.white)
//                            })
//                        }
//                    }
//                    //                    HStack {
//                    //                        Image(systemName: "paintbrush.fill")
//                    //                        Text("Themes")
//                    //                            .frame(maxWidth: .infinity, alignment: .leading)
//                    //                            .font(.title)
//                    //                    }
//                    HStack {
//                        Image(systemName: "bubble.left.fill")
//                        //                        Text("Notifications")
//                        //                            .frame(maxWidth: .infinity, alignment: .leading)
//                        //                            .font(.title)
//                        VStack {
//                            Toggle("Enable daily Notifications", isOn: $notificationsEnabled)
//                                .padding()
//                                .onChange(of: notificationsEnabled) { newValue in
//                                    updateNotificationSetting(enabled: newValue)
//                                }
//                        }
//                        .onAppear {
//                            checkNotificationAuthorizationStatus()
//                        }
//                    }
//                    //                    HStack {
//                    //                        Text("Trigger notifcation at ")
//                    //                        HStack(spacing: 0) {
//                    //                            Image(systemName: "clock.fill")
//                    //                                .imageScale(.large)
//                    //                            DatePicker("", selection: $notifcationTime, displayedComponents: .hourAndMinute)
//                    //                        }
//                    //                    }
//                }
//                Spacer()
//                Section {
//                    Text("Contact us")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    //                    HStack {
//                    //                        Image(systemName: "star.square.on.square.fill")
//                    //                        Text("Rate the app")
//                    //                            .frame(maxWidth: .infinity, alignment: .leading)
//                    //                            .font(.title)
//                    //                    }
//                    HStack {
//                        Image(systemName: "envelope.fill")
//                        Text("Email")
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .font(.title)
//                    }
//                }
//                Spacer()
//                Section {
//                    Text("Help")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    HStack {
//                        Image(systemName: "bubble.left.and.bubble.right.fill")
//                        Text("Share with your friends")
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .font(.title)
//                    }
//                }
//                Spacer()
//                Text("Version 0.1")
//            }
//        }
//        .padding(30)
//    }
//    
//    private func checkNotificationAuthorizationStatus() {
//        UNUserNotificationCenter.current().getNotificationSettings { settings in
//            DispatchQueue.main.async {
//                notificationsEnabled = settings.authorizationStatus == .authorized
//            }
//        }
//    }
//    
//    private func updateNotificationSetting(enabled: Bool) {
//        if enabled {
//            requestNotificationAuthorization()
//        } else {
//            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
//        }
//    }
//    
//    private func requestNotificationAuthorization() {
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
//            if granted {
//                print("Granted!")
//            } else {
//                // Handle authorization failure or error
//                print("Notification authorization denied.")
//            }
//        }
//    }
//}
