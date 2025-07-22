//
//  CharacterUseCase.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 17/7/25.
//

import Foundation

protocol CharacterUseCase: Sendable {
    var cacheExists: Bool { get }
    
    func execute(
        endpoint: RickMortyEndpoints,
        currentCharacters: [Character]
    ) async throws -> CharacterContainer
    func getCachedCharacters() throws -> CharacterContainer?
}

struct CharacterUseCaseImpl: CharacterUseCase {
    
    let repository: CharacterRepository
    
    var cacheExists: Bool {
        repository.hasValidCache
    }
    
    func execute(
        endpoint: RickMortyEndpoints,
        currentCharacters: [Character]
    ) async throws -> CharacterContainer {
        
        switch endpoint {
        case .character(let page):
            return try await executeGetCharacter(id: page)
        case .absolute(let url):
            return try await executeNextPagination(url: url, currentCharacters: currentCharacters)
        default:
            throw APIError.unsupportedEndpoint(endpoint: endpoint)
        }
    }
    
    func getCachedCharacters() throws -> CharacterContainer? {
        try repository.getCachedCharacters()
    }
    
    /// Fetches the initial or specified page of characters.
    ///
    /// If `id` is nil, attempts to return cached characters before making a network request.
    ///
    /// - Parameter id: Optional page number for pagination.
    /// - Returns: A CharacterContainer containing characters and pagination info.
    /// - Throws: Throws if the repository fails to fetch or cache data.
    func executeGetCharacter(id: Int?) async throws -> CharacterContainer {
        let remoteContainer = try await repository.getCharacters(endpoint: .character(page: id))
        
        try repository.saveCharactersToCache(remoteContainer)
        return remoteContainer
    }
    
    func executeNextPagination(url: URL?, currentCharacters: [Character]) async throws -> CharacterContainer {
        
        guard let url else {
            let lastInfo = try repository.getCachedCharacters()?.info ?? .empty
            return CharacterContainer(info: lastInfo, results: currentCharacters)
        }
        
        let newPageContainer = try await repository.getCharacters(endpoint: .absolute(url: url))
        
        let combinedResults = currentCharacters + newPageContainer.results
        let updateContainer = CharacterContainer(info: newPageContainer.info, results: combinedResults)
        try repository.saveCharactersToCache(updateContainer)
        return updateContainer
    }
}
