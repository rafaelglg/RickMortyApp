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
    var isLoadingMore: Bool { get }
    var canLoadMore: Bool { get }
    
    func getCharacters() async
    func loadMoreCharacters() async
    func hasReachedEnd(of character: Character) -> Bool
}

@Observable
@MainActor
final class CharacterViewModelImpl: CharacterViewModel {
    
    let useCase: CharacterUseCase
    
    private(set) var characters: [Character] = []
    private(set) var loadState: LoadState<[Character]> = .initial
    private(set) var isLoadingMore: Bool = false
    private(set) var nextCharactersPageURL: URL?

    private(set) var paginationInfo: CharacterContainer? {
        didSet {
            nextCharactersPageURL = paginationInfo
                .flatMap { $0.info.next }
                .flatMap { URL(string: $0) }
        }
    }
    
    var canLoadMore: Bool {
        return !isLoadingMore && nextCharactersPageURL != nil
    }
    
    init(useCase: CharacterUseCase) {
        self.useCase = useCase
    }
    
    /// Fetches the initial set of characters from the use case.
    /// This method handles the primary state transitions for the view.
    func getCharacters() async {
        guard case .loading = loadState else { return }
        
        loadState = .loading
        
        do {
            let container = try await useCase.execute(endpoint: .character(page: nil))
            characters = container.results
            paginationInfo = container
            loadState = .success(characters)
        } catch {
            loadState = .failure(error)
        }
    }
    
    /// Fetches the next page of characters using the `nextCharactersPageURL`.
    /// This method will exit early if a pagination request is already in progress or if the last page has been reached.
    func loadMoreCharacters() async {
        guard !isLoadingMore, let url = nextCharactersPageURL else { return }

        isLoadingMore = true
        defer { isLoadingMore = false }

        do {
            let container = try await useCase.execute(endpoint: .absolute(url: url))
            characters.append(contentsOf: container.results)
            paginationInfo = container
        } catch {
            loadState = .failure(error)
        }
    }
    
    /// Determines if a given character is the last one in the currently loaded `characters` array.
    /// This is used by the view to detect when the user has scrolled to the end of the list.
    /// - Parameter character: The character instance from the view to check against the data source.
    /// - Returns: `true` if the provided character is the last element, `false` otherwise.
    func hasReachedEnd(of character: Character) -> Bool {
        characters.last == character
    }
}
