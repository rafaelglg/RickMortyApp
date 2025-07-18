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
    let loadState: LoadState<[Character]>
    
    var characterContainer: CharacterContainer?
    var isLoadingMore: Bool = false
    var characters: [Character]
    var canLoadMore: Bool = true
    
    init(
        characters: [Character] = Character.mocks,
        delay: Double = 0.0,
        loadState: LoadState<[Character]> = .initial
    ) {
        self.characters = characters
        self.delay = delay
        self.loadState = loadState
    }
    
    func getCharacters() async {
        try? await Task.sleep(for: .seconds(delay))
    }
    
    func loadMoreCharacters() async {
        isLoadingMore = true
        try? await Task.sleep(for: .seconds(1.5))
        isLoadingMore = false
        characters.append(Character.mock)
    }
    
    func hasReachedEnd(of character: Character) -> Bool {
        characters.last == character
    }
}
