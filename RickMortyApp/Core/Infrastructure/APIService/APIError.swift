//
//  APIError.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 17/7/25.
//

import Foundation

enum APIError: Error, LocalizedError, Equatable {
    case invalidURL
    case requestFailed(statusCode: Int)
    case decodingError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The API endpoint URL is invalid."
        case .requestFailed(let statusCode):
            return "The API request failed with status code \(statusCode)."
        case .decodingError(let error):
            return "Failed to process the server's response due to error: \(error.localizedDescription)."
        }
    }
    
    static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL):
            return true
        case let (.requestFailed(lhsCode), .requestFailed(rhsCode)):
            return lhsCode == rhsCode
        case let (.decodingError(lhsError), .decodingError(rhsError)):
            return String(describing: lhsError) == String(describing: rhsError)
        default:
            return false
        }
    }
}
