//
//  APIService.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 17/7/25.
//

import Foundation

protocol APIService: Sendable {
    func fetchCharacters<T: Codable>(endpoint: RickMortyEndpoints) async throws -> T
}

struct APIServiceImpl: APIService {
    
    /// Performs an asynchronous network request to the specified endpoint and decodes the response.
    ///
    /// - Parameter endpoint: The API endpoint to request.
    /// - Returns: A decoded object of type `T` conforming to `Codable`.
    /// - Throws: An `APIError` if the URL is invalid, the request fails, or decoding fails.
    func fetchCharacters<T: Codable>(endpoint: RickMortyEndpoints) async throws -> T {
        let url = try buildURL(endpoint: endpoint)
        let (data, response) = try await URLSession.shared.data(from: url)
        try handleResponse(response: response)
        let decode = try JSONDecoder().decode(T.self, from: data)
        return decode
    }
    
    /// Constructs a valid `URL` from the given endpoint.
    ///
    /// - Parameter endpoint: The API endpoint path.
    /// - Returns: A fully constructed `URL`.
    /// - Throws: `APIError.invalidURL` if the URL is malformed.
    func buildURL(endpoint: RickMortyEndpoints) throws -> URL {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.host
        components.path = endpoint.basePath + endpoint.path
        components.queryItems = endpoint.queryItems
        
        guard let url = components.url else {
            throw APIError.invalidURL
        }
        
        return url
    }
    
    /// Validates the HTTP response status code.
    ///
    /// - Parameter response: The URL response returned from the server.
    /// - Throws: `APIError.requestFailed` if the status code is not in the 2xx range.
    func handleResponse(response: URLResponse) throws(APIError) {
        
        guard let status = (response as? HTTPURLResponse)?.statusCode else {
            throw APIError.requestFailed(statusCode: -1)
        }
        
        guard (200...299).contains(status) else {
            throw APIError.requestFailed(statusCode: status)
        }
    }
}
