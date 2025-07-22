//
//  CharacterDetailService.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 21/7/25.
//

protocol CharacterDetailService: Sendable {
    func getEpisodes(for id: Int) async throws -> Episode
}

struct CharacterDetailServiceImpl: CharacterDetailService {
    let apiService: APIService
    
    func getEpisodes(for id: Int) async throws -> Episode {
        try await apiService.fetch(endpoint: .episodeDetails(id: id))
    }
}
