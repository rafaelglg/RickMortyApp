//
//  MockPersistanceServices.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 19/7/25.
//

import Foundation

@Observable
final class MockPersistanceServices: PersistanceServices {
    var remote: RemotePersistance { FirebaseRemotePersistance() }
    var local: LocalPersistance { CacheManagerMock() }
}
