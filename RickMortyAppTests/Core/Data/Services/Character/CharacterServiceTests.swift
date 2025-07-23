//
//  CharacterServiceTests.swift
//  RickMortyAppTests
//
//  Created by Rafael Loggiodice on 22/7/25.
//

import Testing
@testable import RickMortyApp

struct CharacterServiceTests {
    
    let apiMock: APIServiceMock = APIServiceMock()
    var sut: CharacterService
    
    init() {
        sut = CharacterServiceImpl(apiService: apiMock)
    }

    @Test func getCharacters_returnValidData() async throws {
        apiMock.result = CharacterContainer.init(info: .empty, results: Character.mocks)
        let response = try await sut.getCharacters(endpoint: .character(page: 1))
        
        let gender = response.results.first?.gender ?? ""
        
        #expect(response != nil)
        #expect(gender == "Male")
        
        #expect(apiMock.endpointSelected?.path == "/character")
    }
}
