//
//  CharacterViewModel.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 17/7/25.
//

import Foundation

@MainActor
protocol CharacterViewModel: Sendable {
    var characters: [Character] { get }
    var loadState: LoadState<[Character]> { get }
    
    func getCharacter() async
}

@Observable
@MainActor
final class CharacterViewModelImpl: CharacterViewModel {
    
    let useCase: CharacterUseCase
    private(set) var characters: [Character] = []
    private(set) var loadState: LoadState<[Character]> = .initial
    
    init(useCase: CharacterUseCase) {
        self.useCase = useCase
    }
    
    func getCharacter() async {
        loadState = .loading
        
        do {
            characters = try await useCase.execute()
            loadState = .success(characters)
        } catch {
            loadState = .failure(error)
        }
    }
}
