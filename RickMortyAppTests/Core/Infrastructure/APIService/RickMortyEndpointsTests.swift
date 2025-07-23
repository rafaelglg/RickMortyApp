//
//  RickMortyEndpointsTests.swift
//  RickMortyAppTests
//
//  Created by Rafael Loggiodice on 22/7/25.
//

import Testing
import Foundation
@testable import RickMortyApp

struct RickMortyEndpointsTests {
    
    @Test
    func absoluteEndpointPathIsEmpty() {
        let endpoint = RickMortyEndpoints.absolute(url: URL(string: "https://example.com"))
        #expect(endpoint.path.isEmpty == true)
    }
    
    @Test func characterEndpointWithoutPage() async throws {
        
        let endpoint = RickMortyEndpoints.character(page: nil)
        let url = try endpoint.asURL()
        
        #expect(url.absoluteString == "https://rickandmortyapi.com/api/character")
    }
    
    @Test func characterEndpointWithPage() throws {
        let endpoint = RickMortyEndpoints.character(page: 2)
        let url = try endpoint.asURL()
        
        #expect(url.absoluteString == "https://rickandmortyapi.com/api/character?page=2")
    }
    
    @Test func filterCharactersWithName() throws {
        let filter = CharacterFilter(name: "rick")
        let endpoint = RickMortyEndpoints.filterCharacters(filter: filter)
        let url = try endpoint.asURL()
        
        #expect(url.absoluteString == "https://rickandmortyapi.com/api/character?name=rick")

    }
    
    @Test func filterCharactersWithEmptyName() throws {
        let filter = CharacterFilter(name: "")
        let endpoint = RickMortyEndpoints.filterCharacters(filter: filter)
        let url = try endpoint.asURL()
        
        #expect(url.absoluteString == "https://rickandmortyapi.com/api/character")
    }
    
    @Test func episodeEndpointWithPage() throws {
        let endpoint = RickMortyEndpoints.episode(page: 3)
        let url = try endpoint.asURL()
        
        #expect(url.absoluteString == "https://rickandmortyapi.com/api/episode?page=3")
    }
    
    @Test func episodeDetailsEndpoint() throws {
        let endpoint = RickMortyEndpoints.episodeDetails(id: 42)
        let url = try endpoint.asURL()
        
        #expect(url.absoluteString == "https://rickandmortyapi.com/api/episode/42")
    }
    
    @Test func absoluteEndpointWithValidURL() throws {
        let rawURL = URL(string: "https://custom-url.com/resource")!
        let endpoint = RickMortyEndpoints.absolute(url: rawURL)
        let url = try endpoint.asURL()
        
        #expect(url == rawURL)
    }
    
    @Test
    func absoluteEndpointWithNilURLThrows() {
        let endpoint = RickMortyEndpoints.absolute(url: nil)
        
        do {
            _ = try endpoint.asURL()
            Issue.record("Expected to throw, but it didn't")
        } catch let error as APIError {
            #expect(error == .invalidURL)
        } catch {
            Issue.record("Unexpected error: \(error)")
        }
    }
}
