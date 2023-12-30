//
//  LoadingView.swift
//  StoicQuotes
//
//  Created by Julian Rakow on 23.10.23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            ProgressView("Loading...")
                .progressViewStyle(CircularProgressViewStyle(tint: .indigo))
                .scaleEffect(2)
                // doubling the loading spinner size here
        }
    }
}

#Preview {
    LoadingView()
}
