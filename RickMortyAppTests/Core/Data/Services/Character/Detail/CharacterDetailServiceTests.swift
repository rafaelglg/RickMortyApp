//
//  CharacterDetailServiceTests.swift
//  RickMortyAppTests
//
//  Created by Rafael Loggiodice on 22/7/25.
//

import Testing
@testable import RickMortyApp

struct CharacterDetailServiceTests {

    let apiServiceMock: APIServiceMock = APIServiceMock()
    var sut: CharacterDetailService?
    
    init() {
        sut = CharacterDetailServiceImpl(apiService: apiServiceMock)
    }
    
    @Test func getEpisodes_returnValidData() async throws {
        guard let sut else { return }
        apiServiceMock.result = Episode.mock

        let response: Episode? = try await sut.getEpisodes(for: 1)
        
        #expect(response?.id == 1)
        #expect(response?.name == "Close Rick-counters of the Rick Kind")
        #expect(response?.airDate == "December 2, 2013")
        #expect(response?.episode == "S01E01")
    }
}
