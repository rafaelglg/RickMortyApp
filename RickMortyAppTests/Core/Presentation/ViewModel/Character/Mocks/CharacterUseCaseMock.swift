//
//  CharacterUseCaseMock.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 23/7/25.
//

@testable import RickMortyApp

final class CharacterUseCaseMock: CharacterUseCase, @unchecked Sendable {
    
    var cachedCharacter: CharacterContainer?
    var executeError: Error?
    
    var cacheExists: Bool {
        cachedCharacter != nil
    }
    
    func execute(endpoint: RickMortyEndpoints, currentCharacters: [Character]) async throws -> CharacterContainer {
        
        if let executeError {
            throw executeError
        }
        
        return CharacterContainer(info: .empty, results: Character.mocks)
    }
    
    func getCachedCharacters() throws -> CharacterContainer? {
        cachedCharacter
    }
}
