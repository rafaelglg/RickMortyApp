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
    var loadMoreError: Error? { get }
    
    var searchText: String { get set }
    
    func getCharacters() async
    func loadMoreCharacters() async
    func hasReachedEnd(of character: Character) -> Bool
    func searchCharacters(query: String) async
}

@Observable
@MainActor
final class CharacterViewModelImpl: CharacterViewModel {
    
    let useCase: CharacterUseCase
    let network: NetworkManager
    
    private(set) var characters: [Character] = []
    private(set) var loadState: LoadState<[Character]> = .initial
    private(set) var isLoadingMore: Bool = false
    private(set) var nextCharactersPageURL: URL?
    private(set) var loadMoreError: Error?
    
    var searchText: String = ""

    /// Holds the complete pagination metadata from the last API response.
    /// A `didSet` observer automatically parses the `next` URL string and updates `nextCharactersPageURL`.
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
    
    init(
        useCase: CharacterUseCase,
        network: NetworkManager
    ) {
        self.useCase = useCase
        self.network = network
    }
    
    /// Fetches the initial character list, prioritizing the local cache
    ///
    /// This method first attempts to load data from the local cache. If successful, the network
    /// request is skipped to maintain the user's full pagination state from the previous session.
    /// A network fetch is only performed if the cache is empty.
    func getCharacters() async {
        guard characters.isEmpty || !useCase.cacheExists else { return }
        await performGetCharacters()
    }
    
    func performGetCharacters() async {
        loadState = .loading
        
        if let cachedContainer = try? useCase.getCachedCharacters() {
            characters = cachedContainer.results
            paginationInfo = cachedContainer
            self.loadState = .success(characters)
            return
        }
        
        do {
            let container = try await useCase.execute(
                endpoint: .character(page: nil),
                currentCharacters: []
            )
            
            characters = container.results
            paginationInfo = container
            loadMoreError = nil
            loadState = .success(characters)
        } catch {
            loadState = .failure(error)
        }
    }
    
    /// Fetches the next page of characters and updates the character list.
    ///
    /// This method calls the use case to handle fetching, combining results, and updating the cache.
    /// The ViewModel then replaces its state with the new, complete data set returned by the use case.
    func loadMoreCharacters() async {
        guard network.isConnected else {
            loadMoreError = AppError.networkError
            return
        }
        
        guard !isLoadingMore else { return }

        isLoadingMore = true
        defer { isLoadingMore = false }

        do {
            let container = try await useCase.execute(
                endpoint: .absolute(url: nextCharactersPageURL),
                currentCharacters: characters
            )
            characters = container.results
            paginationInfo = container
        } catch {
            loadMoreError = error
            if characters.isEmpty {
                loadState = .failure(error)
            }
        }
    }
    
    /// Determines if a given character is the last one in the currently loaded `characters` array.
    /// This is used by the view to detect when the user has scrolled to the end of the list.
    /// - Parameter character: The character instance from the view to check against the data source.
    /// - Returns: `true` if the provided character is the last element, `false` otherwise.
    func hasReachedEnd(of character: Character) -> Bool {
        characters.last == character
    }
    
    func searchCharacters(query: String) async {
        guard !query.isEmpty else {
            await performGetCharacters()
            return
        }
        
        loadState = .loading
        characters = []
        
        // Kind of debounce
        try? await Task.sleep(for: .milliseconds(500))
        
        do {
            let filter = CharacterFilter(name: query)
            let container = try await useCase.execute(
                endpoint: .filterCharacters(filter: filter),
                currentCharacters: []
            )
            characters = container.results
            paginationInfo = container
            loadState = .success(characters)
        } catch {
            loadState = .failure(error)
        }
    }
}
