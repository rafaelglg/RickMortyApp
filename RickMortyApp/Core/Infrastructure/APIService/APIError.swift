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
    case noNextPage
    case unsupportedEndpoint(endpoint: RickMortyEndpoints)
    case itemNotFound
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The API endpoint URL is invalid."
        case .requestFailed(let statusCode):
            return "The API request failed with status code \(statusCode)."
        case .decodingError(let error):
            return "Failed to process the server's response due to error: \(error.localizedDescription)."
        case .noNextPage:
            return "There is no next page available."
        case .unsupportedEndpoint(let endpoint):
            return "Endpoint not supported by RickMortyAPI: \(endpoint)."
        case .itemNotFound: return "The requested character could not be found."
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
        case (.noNextPage, .noNextPage):
            return true
        case (.unsupportedEndpoint, .unsupportedEndpoint):
            return true
        case (.itemNotFound, .itemNotFound):
            return true
        default:
            return false
        }
    }
}
