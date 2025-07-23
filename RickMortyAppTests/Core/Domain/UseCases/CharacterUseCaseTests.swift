//
//  CharacterUseCaseTests.swift
//  RickMortyAppTests
//
//  Created by Rafael Loggiodice on 22/7/25.
//

import Testing
import Foundation
@testable import RickMortyApp

struct CharacterUseCaseTests {
    
    var repositoryMock: CharacterRepositoryMock = CharacterRepositoryMock()
    var sut: CharacterUseCaseImpl
    
    init() {
        sut = CharacterUseCaseImpl(repository: repositoryMock)
    }

    @Test
    func cacheExists_returnsTrue() throws {
        let characterSaved = CharacterContainer(info: .empty, results: Character.mocks)
        try repositoryMock.saveCharactersToCache(characterSaved)
        let bool = sut.cacheExists
        
        #expect(bool == true)
    }
    
    @Test
    func cacheExists_returnsFalse() {
        let bool = sut.cacheExists
        #expect(bool == false)
    }
    
    @Test
    func execute_usingCharacterWithPagination_returnsSuccess() async throws {
        let response = try await sut.execute(endpoint: .character(page: 1), currentCharacters: Character.mocks)
        
        #expect(response != nil)
        
        #expect(response.results.first?.name == "Rick Sanchez")
    }
    
    @Test
    func execute_usingAbsoluteWithURL_returnsSuccess() async throws {
        let url = URL(string: "https://rickandmortyapi.com/api/character/1")
        let response = try await sut.execute(endpoint: .absolute(url: url), currentCharacters: Character.mocks)
        
        #expect(response != nil)
        #expect(response.results.first?.name == "Rick Sanchez")
    }
    
    @Test
    func execute_usingAbsoluteWithoutURL_returnsSuccess() async throws {
        let response = try await sut.execute(endpoint: .absolute(url: nil), currentCharacters: Character.mocks)
        
        #expect(response != nil)
        #expect(response.results.first?.name == "Rick Sanchez")
    }
    
    @Test
    func execute_usingFilterCharacters_returnsSuccess() async throws {
        let filter: CharacterFilter = CharacterFilter(name: "Rick")
        let response = try await sut.execute(endpoint: .filterCharacters(filter: filter), currentCharacters: Character.mocks)
        
        #expect(response != nil)
        #expect(response.results.first?.name == "Rick Sanchez")
    }
    
    @Test
    func execute_usingEpisodeDetails_throwsError_APIErrorUnsupportedEndpoint() async throws {
        let endpoint: RickMortyEndpoints = .episodeDetails(id: 1)
        do {
            _ = try await sut.execute(endpoint: endpoint, currentCharacters: Character.mocks)
            Issue.record("The request should have failed and thrown an error")
        } catch {
            let apiError = error as? APIError
            #expect(apiError == .unsupportedEndpoint(endpoint: endpoint))
        }
    }
}
