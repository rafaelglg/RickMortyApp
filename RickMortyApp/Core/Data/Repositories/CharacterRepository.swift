//
//  CharacterRepository.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 17/7/25.
//

protocol CharacterRepository: Sendable {
    func getCharacters(endpoint: RickMortyEndpoints) async throws -> CharacterContainer
}

struct CharacterRepositoryImpl: CharacterRepository {
    
    let service: CharacterService
    
    func getCharacters(endpoint: RickMortyEndpoints) async throws -> CharacterContainer {
        try await service.getCharacters(endpoint: endpoint)
    }
}
