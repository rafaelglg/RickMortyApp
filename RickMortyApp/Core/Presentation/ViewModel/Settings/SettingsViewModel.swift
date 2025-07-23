//
//  SettingsViewModel.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 19/7/25.
//

import Foundation

@MainActor
protocol SettingsViewModel {
    var cacheSizeInMB: String { get }
    var isCacheEmpty: Bool { get }
    var showingClearCacheConfirmation: Bool { get set }
    
    func getCacheSizeInMB()
    func clearCache()
    func toggleCacheConfirmation()
}

@Observable
@MainActor
final class SettingsViewModelImpl: SettingsViewModel {
    
    let cacheManager: LocalPersistance
    private(set) var cacheSizeInMB: String = "0.0"
    var showingClearCacheConfirmation: Bool = false
    
    var isCacheEmpty: Bool {
        cacheSizeInMB == "0.0"
    }
    
    init(localPersistance: PersistanceServices) {
        self.cacheManager = localPersistance.local
    }
    
    func getCacheSizeInMB() {
        let cacheSize = try? cacheManager.getCacheSizeInMB()
        cacheSizeInMB = String(format: "%.1f", cacheSize ?? "0.0")
    }
    
    func clearCache() {
        try? cacheManager.clearAll()
        let cacheSize = try? cacheManager.getCacheSizeInMB()
        cacheSizeInMB = String(format: "%.1f", cacheSize ?? "0.0")
    }
    
    func toggleCacheConfirmation() {
        showingClearCacheConfirmation.toggle()
    }
}
