//
//  CharacterRepository.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 17/7/25.
//

protocol CharacterRepository: Sendable {
    var hasValidCache: Bool { get }
    
    func getCharacters(endpoint: RickMortyEndpoints) async throws -> CharacterContainer
    func getCachedCharacters() throws -> CharacterContainer?
    func saveCharactersToCache(_ container: CharacterContainer) throws
}

struct CharacterRepositoryImpl: CharacterRepository {
    
    let service: CharacterService
    let local: LocalPersistance
    let remote: RemotePersistance
    
    var hasValidCache: Bool {
        local.exists
    }
    
    init(
        service: CharacterService,
        persistance: PersistanceServices
    ) {
        self.service = service
        self.local = persistance.local
        self.remote = persistance.remote
    }
    
    func getCachedCharacters() throws -> CharacterContainer? {
        try local.load()
    }
    
    func saveCharactersToCache(_ container: CharacterContainer) throws {
        try local.save(data: container)
    }
    
    func getCharacters(endpoint: RickMortyEndpoints) async throws -> CharacterContainer {
        try await service.getCharacters(endpoint: endpoint)
    }
}
