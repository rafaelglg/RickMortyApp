//
//  MockPersistanceServices.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 19/7/25.
//

import Foundation

@Observable
final class MockPersistanceServices: PersistanceServices {
    let remote: RemotePersistance
    let local: LocalPersistance
    
    init(
        remote: RemotePersistance = FirebaseRemotePersistance(),
        local: LocalPersistance = CacheManagerMock()
    ) {
        self.remote = remote
        self.local = local
    }
}
