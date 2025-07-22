//
//  CharacterService.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 17/7/25.
//

protocol CharacterService: Sendable {
    func getCharacters(endpoint: RickMortyEndpoints) async throws -> CharacterContainer 
}

struct CharacterServiceImpl: CharacterService {
    
    let apiService: APIService
    
    func getCharacters(endpoint: RickMortyEndpoints) async throws -> CharacterContainer {
        let response: CharacterContainer = try await apiService.fetch(endpoint: endpoint)
        return response
    }
}
