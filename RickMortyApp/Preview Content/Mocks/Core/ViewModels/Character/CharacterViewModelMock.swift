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
    
    var loadState: LoadState<[Character]>
    var characterContainer: CharacterContainer?
    var isLoadingMore: Bool = false
    var characters: [Character]
    var canLoadMore: Bool = true
    var loadMoreError: Error?
    
    var searchText: String
    
    init(
        characters: [Character] = Character.mocks,
        delay: Double = 0.0,
        loadState: LoadState<[Character]> = .initial,
        loadMoreError: Error? = nil,
        searchText: String = ""
    ) {
        self.characters = characters
        self.delay = delay
        self.loadState = loadState
        self.loadMoreError = loadMoreError
        self.searchText = searchText
    }
    
    func getCharacters() async {
        try? await Task.sleep(for: .seconds(delay))
    }
    
    func searchCharacters(query: String) async {
        self.searchText = query
        
        if query.isEmpty {
            characters = Character.mocks
        } else {
            characters = characters.filter { character in
                character.name.localizedCaseInsensitiveContains(query)
            }
        }
        
        self.loadState = .success(characters)
    }
    
    func retryLastAction() async { }
    
    func loadMoreCharacters() async {
        
        guard loadMoreError == nil else { return }
        
        isLoadingMore = true
        try? await Task.sleep(for: .seconds(1.5))
        isLoadingMore = false
        characters.append(Character.mock)
    }
    
    func hasReachedEnd(of character: Character) -> Bool {
        characters.last == character
    }
}
