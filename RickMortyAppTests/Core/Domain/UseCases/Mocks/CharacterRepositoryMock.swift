//
//  CharacterRepositoryMock.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 23/7/25.
//

@testable import RickMortyApp

final class CharacterRepositoryMock: CharacterRepository, @unchecked Sendable {
    
    var cachedCharater: CharacterContainer?
    
    var hasValidCache: Bool {
        characterSaved != nil
    }
    
    var characterSaved: CharacterContainer?
    
    func getCharacters(endpoint: RickMortyEndpoints) async throws -> CharacterContainer {
        CharacterContainer(info: .empty, results: Character.mocks)
    }
    
    func getCachedCharacters() throws -> CharacterContainer? {
        cachedCharater
    }
    
    func saveCharactersToCache(_ container: CharacterContainer) throws {
        characterSaved = container
    }
    
}
