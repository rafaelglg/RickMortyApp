//
//  ImageLoaderViewModelTests.swift
//  RickMortyAppTests
//
//  Created by Rafael Loggiodice on 23/7/25.
//

import Testing
import Foundation
@testable import RickMortyApp

@MainActor
final class ImageLoaderViewModelTests {
    
    var persistanceMock: MockPersistanceServices = MockPersistanceServices()
    var sut: ImageLoaderViewModelImpl
    let url = URL(string: "https://rickandmortyapi.com/api/character/avatar/10.jpeg")!
    
    init() {
        sut = ImageLoaderViewModelImpl(persistance: persistanceMock, url: url)
    }
    
    @Test func loadImage_loadsFromCache() async throws {
        
        if let cacheManagerMock = persistanceMock.local as? CacheManagerMock {
            let dummyData = Data("cached image".utf8)
            cacheManagerMock.shouldReturnImageData = dummyData
            await sut.loadImage()
            #expect(sut.loadState == .success(dummyData))
        }
    }
    
    @Test func loadImage_loadsRest() async throws {
        
        if let cacheManagerMock = persistanceMock.local as? CacheManagerMock {
            cacheManagerMock.shouldReturnImageData = nil 
            await sut.loadImage()
            #expect(cacheManagerMock.savedCacheKey == url.lastPathComponent)
            #expect(sut.loadState != nil)
            #expect(cacheManagerMock.savedCacheImage != nil)
        }
    }
    
    @Test func loadImage_throwsError() async throws {
        
        if let cacheManagerMock = persistanceMock.local as? CacheManagerMock {
            cacheManagerMock.saveImageError = APIError.invalidURL
            await sut.loadImage()
            #expect(sut.loadState != nil)
            #expect(sut.loadState == .failure(APIError.invalidURL))
        }
    }
}
