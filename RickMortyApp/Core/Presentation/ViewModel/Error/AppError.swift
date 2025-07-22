//
//  AppError.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 21/7/25.
//

import Foundation

enum AppError: Error, LocalizedError {
    case networkError
    
    var errorDescription: String? {
        switch self {
        case .networkError:
            return "No internet connection. Please check your network settings."
        }
    }
}
