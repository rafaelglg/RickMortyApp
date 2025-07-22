//
//  NetworkManager.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 21/7/25.
//

import Foundation
import Network

@MainActor
protocol NetworkStatusProvider {
    var isConnected: Bool { get }
}

@MainActor
@Observable
final class NetworkManager: NetworkStatusProvider, ObservableObject {
    
    static let shared = NetworkManager()
    let networkMonitor: NWPathMonitor = NWPathMonitor()
    let workingQueue = DispatchQueue(label: "NetworkManager")
    
    var isConnected: Bool = false
    
    private init() {
        startMonitoring()
    }
    
    func startMonitoring() {
        networkMonitor.pathUpdateHandler = { [weak self] path in
            guard let self else { return }
            
            Task {
                await MainActor.run {
                    self.isConnected = path.status == .satisfied
                }
            }
        }
        
        networkMonitor.start(queue: workingQueue)
    }
}
