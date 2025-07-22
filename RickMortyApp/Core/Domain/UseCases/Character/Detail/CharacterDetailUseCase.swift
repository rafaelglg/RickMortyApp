//
//  CharacterDetailUseCase.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 21/7/25.
//

protocol CharacterDetailUseCase: Sendable {
    func getEpisodes(for id: Int) async throws -> Episode
}

struct CharacterDetailUseCaseImpl: CharacterDetailUseCase {
    let repository: CharacterDetailRepository
    
    func getEpisodes(for id: Int) async throws -> Episode {
        try await repository.getEpisodes(for: id)
    }
}
