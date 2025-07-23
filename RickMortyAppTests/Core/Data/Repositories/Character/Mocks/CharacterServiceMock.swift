//
//  CharacterServiceMock.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 22/7/25.
//

@testable import RickMortyApp

struct CharacterServiceMock: CharacterService {
    func getCharacters(endpoint: RickMortyEndpoints) async throws -> CharacterContainer {
        CharacterContainer.init(info: .empty, results: Character.mocks)
    }
}
