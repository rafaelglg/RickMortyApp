//
//  SettingsViewModelTests.swift
//  RickMortyAppTests
//
//  Created by Rafael Loggiodice on 23/7/25.
//

import Testing
@testable import RickMortyApp

@MainActor
struct SettingsViewModelTests {
    
    let persitanceMock: PersistanceServices = MockPersistanceServices()
    var sut: SettingsViewModelImpl
    
    init() {
        sut = SettingsViewModelImpl(localPersistance: persitanceMock)
    }
    
    @Test("")
    func isCacheEmpty_returnTrue() {
        #expect(sut.isCacheEmpty == true)
    }

    @Test func getCacheSizeInKB() {
        sut.getCacheSizeInMB()
        
        #expect(sut.cacheSizeInMB == "75.4")
    }
    
    @Test func clearCache_successfully() {
        sut.clearCache()
        
        if let cacheMock = persitanceMock.local as? CacheManagerMock {
            cacheMock.sizeInCache = 0
            let cacheSize = try? cacheMock.getCacheSizeInMB()
            
            #expect(cacheSize == 0.0)
        }
    }
    
    @Test func toggleCacheConfirmation_togglesStateCorrectly() {
        #expect(sut.showingClearCacheConfirmation == false)

        sut.toggleCacheConfirmation()
        #expect(sut.showingClearCacheConfirmation == true)

        sut.toggleCacheConfirmation()
        #expect(sut.showingClearCacheConfirmation == false)
    }
}
