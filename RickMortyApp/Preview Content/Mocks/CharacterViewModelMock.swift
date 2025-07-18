//
//  CharacterViewModelMock.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 17/7/25.
//
import Foundation

@Observable
@MainActor
final class CharacterViewModelMock: CharacterViewModel {
    let delay: Double
    let characters: [Character]
    let loadState: LoadState<[Character]>
    
    init(
        characters: [Character] = Character.mocks,
        delay: Double = 0.0,
        loadState: LoadState<[Character]> = .initial
    ) {
        self.characters = characters
        self.delay = delay
        self.loadState = loadState
    }
    
    func getCharacter() async {
        try? await Task.sleep(for: .seconds(delay))
    }
}
