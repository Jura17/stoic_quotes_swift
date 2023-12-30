//
//  NetworkError.swift
//  StoicQuotes
//
//  Created by Julian Rakow on 13.10.23.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
}
