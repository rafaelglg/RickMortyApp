//
//  CharacterDetailUseCaseTests.swift
//  RickMortyAppTests
//
//  Created by Rafael Loggiodice on 22/7/25.
//

import Testing
@testable import RickMortyApp

struct CharacterDetailUseCaseTests {
    
    var mockRepository: CharacterDetailRepositoryMock = CharacterDetailRepositoryMock()
    var sut: CharacterDetailUseCase
    
    init() {
        sut = CharacterDetailUseCaseImpl(repository: mockRepository)
    }

    @Test func getEpisodes_returnValidData() async throws {
        let response = try await sut.getEpisodes(for: 1)
        
        #expect(response != nil)
    }
}
