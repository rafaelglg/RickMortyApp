//
//  CharacterRepositoryTests.swift
//  RickMortyAppTests
//
//  Created by Rafael Loggiodice on 22/7/25.
//

import Testing
@testable import RickMortyApp

struct CharacterRepositoryTests {
    
    var serviceMock: CharacterServiceMock = CharacterServiceMock()
    var persistanceMock: PersistanceServices = MockPersistanceServices()
    var sut: CharacterRepository?
    
    init() {
        sut = CharacterRepositoryImpl(service: serviceMock, persistance: persistanceMock)
    }

    @Test func getCachedCharacters_returnValidCharacter() async throws {
        let response = try sut?.getCachedCharacters()
        
        #expect(response == nil)
    }
    
    @Test func hasValidCache_returnsTrue() {
        #expect(sut?.hasValidCache == true)
    }
    
    @Test
    func saveCharactersToCache() throws {
        let container: CharacterContainer = CharacterContainer(info: .empty, results: Character.mocks)
        try sut?.saveCharactersToCache(container)
        
        #expect(container.info.count == Info.empty.count)
    }
    
    @Test
    func getCharacters() async throws {
        let response = try await sut?.getCharacters(endpoint: .episode(page: 1))
        
        #expect(response?.info.count == Info.empty.count)
        #expect(response?.results.first?.imageURL == Character.mocks[0].imageURL)
    }
}
