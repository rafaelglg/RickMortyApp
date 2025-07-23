//
//  NetworkManagerMock.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 23/7/25.
//

@testable import RickMortyApp

final class NetworkManagerMock: NetworkStatusProvider {
    var isConnected: Bool = true
}
