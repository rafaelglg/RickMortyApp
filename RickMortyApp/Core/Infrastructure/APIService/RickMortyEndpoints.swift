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
    case absolute(url: URL?)
    case episodeDetails(id: Int)
    
    /// The path component of the endpoint.
    ///
    /// For `.absolute`, this returns an empty string since the full URL is provided.
    var path: String {
        switch self {
        case .character: return "/character"
        case .episode: return "/episode"
        case .absolute: return ""
        case .episodeDetails(id: let id): return "/episode/\(id)"
        }
    }
    
    /// The URL scheme used by the API (e.g., "https").
     var scheme: String { "https" }
     
     /// The host of the Rick and Morty API.
     var host: String { "rickandmortyapi.com" }
     
     /// The base path for all API endpoints.
     var basePath: String { "/api" }
    
    /// The query items to include in the URL, such as the page number.
    ///
    /// Only applies to paginated endpoints (`character`, `episode`, `location`).
    var queryItems: [URLQueryItem]? {
        switch self {
        case .character(let page),
                .episode(let page):
            if let page {
                return [URLQueryItem(name: "page", value: "\(page)")]
            }
            return nil
        case .absolute, .episodeDetails: return nil
        }
    }
    
    /// Constructs a full `URL` for the selected endpoint.
    ///
    /// - Throws: `APIError.invalidURL` if the URL could not be constructed.
    /// - Returns: A valid `URL` ready for network requests.
    func asURL() throws -> URL {
        switch self {
        case .absolute(let url):
            guard let url else {
                throw APIError.invalidURL
            }
            return url
        default:
            var components = URLComponents()
            components.scheme = scheme
            components.host = host
            components.path = basePath + path
            components.queryItems = queryItems
            
            guard let url = components.url else {
                throw APIError.invalidURL
            }
            return url
        }
    }
}
