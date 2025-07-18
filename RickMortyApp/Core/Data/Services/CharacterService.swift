//
//  CharacterService.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 17/7/25.
//

protocol CharacterService: Sendable {
    func getCharacters() async throws -> [Character]
}

struct CharacterServiceImpl: CharacterService {
    
    let apiService: APIService
    
    func getCharacters() async throws -> [Character] {
        let response: CharacterContainer = try await apiService.fetchCharacters(
            endpoint: .character(page: 15)
        )
        return response.results
    }
}
