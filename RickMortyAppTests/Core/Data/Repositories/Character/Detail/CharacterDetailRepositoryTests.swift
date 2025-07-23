//
//  CharacterDetailRepositoryTests.swift
//  RickMortyAppTests
//
//  Created by Rafael Loggiodice on 22/7/25.
//

import Testing
@testable import RickMortyApp

struct CharacterDetailRepositoryTests {
    
    var serviceMock: CharacterDetailServiceMock = CharacterDetailServiceMock()
    var sut: CharacterDetailRepository
    
    init() {
        sut = CharacterDetailRepositoryImpl(service: serviceMock)
    }

    @Test func getEpisodes_returnValidData() async throws {
        let response = try await sut.getEpisodes(for: 1)
        
        #expect(response.id == 1)
        #expect(response.name == "Close Rick-counters of the Rick Kind")
        #expect(response.airDate == "December 2, 2013")
        #expect(response.episode == "S01E01")
    }
}
