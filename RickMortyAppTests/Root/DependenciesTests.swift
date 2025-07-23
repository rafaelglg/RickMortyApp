//
//  DependenciesTests.swift
//  RickMortyAppTests
//
//  Created by Rafael Loggiodice on 22/7/25.
//

import Testing
@testable import RickMortyApp

struct DependenciesTests {

    var sut: Dependencies
    
    init() {
        sut = DependenciesImpl()
    }
    
    @Test func makeCharacterDetailViewModel() async throws {
        let viewModel = await sut.makeCharacterDetailViewModel()
        
        #expect(viewModel != nil)
    }

}
