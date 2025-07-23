//
//  EpisodeTests.swift
//  RickMortyAppTests
//
//  Created by Rafael Loggiodice on 22/7/25.
//

import Testing
@testable import RickMortyApp

struct EpisodeTests {
    
    @Test("Static 'empty' property should contain zero or empty values")
    func testStaticEmptyProperty() {
        let emptyEpisode = Episode.empty
        
        #expect(emptyEpisode.id == 0)
        #expect(emptyEpisode.name.isEmpty == true)
        #expect(emptyEpisode.airDate.isEmpty == true)
        #expect(emptyEpisode.characters.isEmpty == true)
    }
    
    @Test("Static 'mock' property should be the first element of 'mocks'")
    func testStaticMockProperty() {
        let mockEpisode = Episode.mock
        let firstFromMocks = Episode.mocks.first
        
        #expect(firstFromMocks != nil, "The mocks array should not be empty.")
        #expect(mockEpisode == firstFromMocks, "The 'mock' property should be identical to the first element in the 'mocks' array.")
    }
    
    @Test("Static 'mocks' array should contain the expected number of elements")
    func testStaticMocksArray() {
        let mocksArray = Episode.mocks
        
        #expect(mocksArray.isEmpty == false, "The mocks array should not be empty.")
        #expect(mocksArray.count == 5, "The mocks array should contain 5 episodes as provided.")
    }

}
