//
//  CharacterDetailUseCaseMock.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 23/7/25.
//

@testable import RickMortyApp

final class CharacterDetailUseCaseMock: CharacterDetailUseCase, @unchecked Sendable {
    
    var error: Error?
    func getEpisodes(for id: Int) async throws -> Episode {
        
        if let error {
            throw error
        }
        
        return Episode.mock
    }
}
