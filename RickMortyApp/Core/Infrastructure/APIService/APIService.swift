//
//  APIService.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 17/7/25.
//

import Foundation

protocol APIService: Sendable {
    func fetch<T: Codable>(endpoint: RickMortyEndpoints) async throws -> T
}

struct APIServiceImpl: APIService {
    
    /// Performs an asynchronous network request to the specified endpoint and decodes the response.
    ///
    /// - Parameter endpoint: The API endpoint to request.
    /// - Returns: A decoded object of type `T` conforming to `Codable`.
    /// - Throws: An `APIError` if the URL is invalid, the request fails, or decoding fails.
    func fetch<T: Codable>(endpoint: RickMortyEndpoints) async throws -> T {
        let url = try endpoint.asURL()
        let (data, response) = try await URLSession.shared.data(from: url)
        try handleResponse(response: response)
        let decode = try JSONDecoder().decode(T.self, from: data)
        return decode
    }
    
    /// Validates the HTTP response status code.
    ///
    /// - Parameter response: The URL response returned from the server.
    /// - Throws: `APIError.requestFailed` if the status code is not in the 2xx range.
    func handleResponse(response: URLResponse) throws(APIError) {
        
        guard let status = (response as? HTTPURLResponse)?.statusCode else {
            throw APIError.requestFailed(statusCode: -1)
        }
        
        switch status {
        case 200...299:
            return
        case 404:
            throw APIError.itemNotFound
        default:
            throw APIError.requestFailed(statusCode: status)
        }
    }
}
