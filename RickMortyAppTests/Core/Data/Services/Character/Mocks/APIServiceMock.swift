//
//  APIServiceMock.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 22/7/25.
//

@testable import RickMortyApp

final class APIServiceMock: APIService, @unchecked Sendable {
    
    var endpointSelected: RickMortyEndpoints?
    var result: Any?
    
    func fetch<T: Codable>(endpoint: RickMortyEndpoints) async throws -> T {
        endpointSelected = endpoint
        
        guard let episode = result as? T else {
            throw APIError.invalidURL
        }
        
        return episode
    }
}
