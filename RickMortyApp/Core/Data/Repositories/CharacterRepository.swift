//
//  CharacterRepository.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 17/7/25.
//

protocol CharacterRepository: Sendable {
    func getCharacters() async throws -> [Character]
}

struct CharacterRepositoryImpl: CharacterRepository {
    
    let service: CharacterService
    
    func getCharacters() async throws -> [Character] {
        try await service.getCharacters()
    }
    
}
