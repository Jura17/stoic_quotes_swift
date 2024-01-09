//
//  SwipeToFetchView.swift
//  StoicQuotes
//
//  Created by Julian Rakow on 09.01.24.
//

import SwiftUI

struct SwipeToFetchView: View {
    
    @ObservedObject var viewModel: QuoteFeedViewModel
    @State private var isDragging = false
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { _ in self.isDragging = true
                viewModel.fetchQuote()
            }
            .onEnded { _ in self.isDragging = false }
    }
    
    var body: some View {
        VStack {
            Text(viewModel.quote)
                .font(.title)
                .multilineTextAlignment(.center)
                .padding(20)
            Text(viewModel.author)
                .font(.subheadline)
                .multilineTextAlignment(.center)
        }
        .gesture(drag)
    }
}
