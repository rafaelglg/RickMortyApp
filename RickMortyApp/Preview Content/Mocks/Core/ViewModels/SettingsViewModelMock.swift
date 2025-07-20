//
//  SettingsViewModelMock.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 19/7/25.
//

import Foundation

@Observable
@MainActor
final class SettingsViewModelMock: SettingsViewModel {
    var cacheSizeInMB: String = "0.0"
    
    var showingClearCacheConfirmation: Bool = false
    
    var isCacheEmpty: Bool {
        cacheSizeInMB == "0.0"
    }
    
    func getCacheSizeInKB() {
        cacheSizeInMB = "70.2"
    }
    
    func clearCache() {
        cacheSizeInMB = "0.0"
    }
    
    func toggleCacheConfirmation() {
        showingClearCacheConfirmation.toggle()
    }
}
