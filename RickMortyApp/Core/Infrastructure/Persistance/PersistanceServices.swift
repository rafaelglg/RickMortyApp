//
//  PersistanceServices.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 18/7/25.
//

import Foundation

protocol PersistanceServices {
    var remote: RemotePersistance { get }
    var local: LocalPersistance { get }
}

@Observable
final class ProductionPersistanceServices: PersistanceServices {
    var remote: RemotePersistance
    var local: LocalPersistance
    
    init(
        remote: RemotePersistance,
        local: LocalPersistance
    ) {
        self.remote = remote
        self.local = local
    }
}
