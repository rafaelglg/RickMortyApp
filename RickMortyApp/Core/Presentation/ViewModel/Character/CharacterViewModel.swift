//
//  CharacterViewModel.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 17/7/25.
//

import Foundation

@MainActor
protocol CharacterViewModel: Sendable {
    func getCharacter() async throws -> [Character]
}

@Observable
@MainActor
final class CharacterViewModelImpl: CharacterViewModel {
    
    let useCase: CharacterUseCase
    var characters: [Character]?
    
    init(useCase: CharacterUseCase) {
        self.useCase = useCase
    }
    
    func getCharacter() async throws -> [Character] {
        let response = try await useCase.execute()
        characters = response
        return response
    }
}
