////
////  Quote.swift
////  StoicQuotes
////
////  Created by Julian Rakow on 13.10.23.
////
//
import Foundation


struct AnotherQuote: Codable, Identifiable {
    let id: String
    let author: String
    let content: String
}

struct Quote: Codable, Identifiable {
    let id: UUID?
    let author: String
    let quote: String
}

struct Mockdata {
    
    static let sampleList = [
        Quote(
            id: UUID(),
            author: "Bernd",
            quote: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eget ullamcorper urna, et imperdiet mi."),
        Quote(
            id: UUID(),
            author: "Henry",
            quote: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eget ullamcorper urna, et imperdiet mi."),
        Quote(
            id: UUID(),
            author: "Klaus",
            quote: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eget ullamcorper urna, et imperdiet mi."),
        Quote(
            id: UUID(),
            author: "Bernd",
            quote: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eget ullamcorper urna, et imperdiet mi."),
        Quote(
            id: UUID(),
            author: "Henry",
            quote: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eget ullamcorper urna, et imperdiet mi."),
        Quote(
            id: UUID(),
            author: "Klaus",
            quote: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eget ullamcorper urna, et imperdiet mi.")
    ]
    
    static let sampleQuote = Quote(
        id: UUID(),
        author: "Henry",
        quote: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eget ullamcorper urna, et imperdiet mi.")
}
