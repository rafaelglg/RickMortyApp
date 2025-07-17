//
//  CharacterUseCase.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 17/7/25.
//

protocol CharacterUseCase: Sendable {
    func execute() async throws -> [Character]
}

struct CharacterUseCaseImpl: CharacterUseCase {
    
    let repository: CharacterRepository
    
    func execute() async throws -> [Character] {
        try await repository.getCharacters()
    }
}
