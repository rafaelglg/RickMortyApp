//
//  RickMortyEndpoints.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 17/7/25.
//

import Foundation

enum RickMortyEndpoints {
    case character(page: Int?)
    case episode(page: Int?)
    case location(page: Int?)
    
    var path: String {
        switch self {
        case .character: return "/character"
        case .episode: return "/episode"
        case .location: return "/location"
        }
    }
    
    var scheme: String { "https" }
    var host: String { "rickandmortyapi.com" }
    var basePath: String { "/api" }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .character(let page),
                .episode(let page),
                .location(let page):
            if let page {
                return [URLQueryItem(name: "page", value: "\(page)")]
            }
            return nil
        }
    }
}
