//
//  RemotePersistance.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 18/7/25.
//

protocol RemotePersistance: Sendable {
    var exists: Bool { get }
    
    func read<T: Decodable>(character: Character) throws -> T?
    func save(character: Character) throws
    func delete() throws
}
