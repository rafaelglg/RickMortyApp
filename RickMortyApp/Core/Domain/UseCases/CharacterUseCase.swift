//
//  CharacterUseCase.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 17/7/25.
//

protocol CharacterUseCase: Sendable {
    func execute(endpoint: RickMortyEndpoints) async throws -> CharacterContainer
}

struct CharacterUseCaseImpl: CharacterUseCase {
    
    let repository: CharacterRepository
    
    func execute(endpoint: RickMortyEndpoints) async throws -> CharacterContainer {
        try await repository.getCharacters(endpoint: endpoint)
    }
}
