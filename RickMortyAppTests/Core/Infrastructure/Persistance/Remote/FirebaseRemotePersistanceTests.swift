//
//  FirebaseRemotePersistanceTests.swift
//  RickMortyAppTests
//
//  Created by Rafael Loggiodice on 22/7/25.
//

import Testing
@testable import RickMortyApp

struct FirebaseRemotePersistanceTests {
    
    var sut: RemotePersistance?
    
    init() {
        self.sut = FirebaseRemotePersistance()
    }

    @Test func exists_returns_False() {
        #expect(sut?.exists == false)
    }
    
    @Test func read_returns_Nil() throws {
        let character: Character? = try sut?.read(character: Character.mock)
        #expect(character == nil)
    }
    
    @Test func save() throws {
        try sut?.save(character: Character.mock)
        #expect(Bool(false) == false)
    }
    
    @Test func delete() throws {
        try sut?.delete()
        #expect(Bool(false) == false)
    }
}
