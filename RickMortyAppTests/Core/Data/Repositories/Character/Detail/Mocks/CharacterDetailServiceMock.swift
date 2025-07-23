//
//  CharacterDetailServiceMock.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 22/7/25.
//

@testable import RickMortyApp

struct CharacterDetailServiceMock: CharacterDetailService {
    func getEpisodes(for id: Int) async throws -> Episode {
        Episode.mock
    }
}
