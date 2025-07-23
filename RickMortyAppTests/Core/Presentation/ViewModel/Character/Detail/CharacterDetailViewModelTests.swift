//
//  CharacterDetailViewModelTests.swift
//  RickMortyAppTests
//
//  Created by Rafael Loggiodice on 23/7/25.
//

import Testing
@testable import RickMortyApp

@MainActor
struct CharacterDetailViewModelTests {
    
    var useCaseMock: CharacterDetailUseCaseMock = CharacterDetailUseCaseMock()
    var sut: CharacterDetailViewModel
    
    init() {
        sut = CharacterDetailViewModelImpl(useCase: useCaseMock)
    }

    @Test func getEpisodeDetails_setsSuccessState() async {
        
        await sut.getEpisodeDetails(character: Character.mock)
        
        #expect(sut.episode.count == 6)
        #expect(sut.episode.first?.id == 1)
        #expect(sut.episode.first?.name == "Close Rick-counters of the Rick Kind")
        #expect(sut.episode.first?.airDate == "December 2, 2013")
        #expect(sut.episode.first?.episode == "S01E01")
    }
    
    @Test func getEpisodeDetails_throwsError() async throws {
        useCaseMock.error = AppError.networkError
        await sut.getEpisodeDetails(character: Character.mock)
        #expect(sut.loadState == .failure(AppError.networkError))
    }
}
