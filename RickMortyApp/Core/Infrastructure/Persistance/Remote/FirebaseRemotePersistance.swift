//
//  FirebaseRemotePersistance.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 18/7/25.
//

struct FirebaseRemotePersistance: RemotePersistance {
    var exists: Bool { return false }
    
    func delete() throws { }
    func read<T: Decodable>(character: Character) throws -> T? { return nil }
    func save(character: Character) throws { }
}
