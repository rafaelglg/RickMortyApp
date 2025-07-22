//
//  CharacterDetailRepository.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 21/7/25.
//

protocol CharacterDetailRepository: Sendable {
    func getEpisodes(for id: Int) async throws -> Episode
}

struct CharacterDetailRepositoryImpl: CharacterDetailRepository {
    let service: CharacterDetailService
    
    func getEpisodes(for id: Int) async throws -> Episode {
        try await service.getEpisodes(for: id)
    }
}
