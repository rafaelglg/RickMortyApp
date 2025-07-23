//
//  CacheManagerTests.swift
//  RickMortyAppTests
//
//  Created by Rafael Loggiodice on 22/7/25.
//

import Testing
import Foundation
@testable import RickMortyApp

struct CacheManagerTests {
    
    var mockStorage: FileStorageMock = FileStorageMock()
    var sut: CacheManager?
    
    init() {
        sut = CacheManager(storage: mockStorage)
    }
    
    // MARK: - Shared Tests
    @Test("Clear All should call deleteAppCacheFolder on storage")
    func clearAll_callsSuccessfully() throws {
        try sut?.clearAll()
        
        #expect(mockStorage.deleteAppCacheFolderCalled == true)
    }
    
    @Test("Get Cache Size should return correct size in MB")
    func testGetCacheSize() throws {
        mockStorage.codableData["test"] = Data(count: 1024 * 1024)
        mockStorage.imageData["image"] = Data(count: 1024 * 512)
        
        let sizeInMB = try sut?.getCacheSizeInMB()
        
        #expect(sizeInMB == 1.5)
    }
    
    // MARK: - Codable Object Cache Tests
    
    @Test("Exists property should be true when object exists")
    func exists() throws {
        let text: String = "Hello"
        try mockStorage.save(text, forKey: "characters_info")
        #expect(sut?.exists == true)
    }
    
    @Test("Save Codable should call storage with correct dataCacheKey")
    func testSaveCodable() throws {
        
        let text: String = "Hello"
        
        try sut?.save(data: text)
        
        #expect(mockStorage.lastSavedCodableKey == "characters_info")
        
        let loadedData: String? = try mockStorage.load(forKey: "characters_info")
        #expect(loadedData == "Hello")
    }
    
    @Test("Load Codable should return correct object when it exists")
    func testLoadCodable() throws {
        
        let text: String = "Hello"
        try sut?.save(data: text)
        
        let loadedObject: String? = try sut?.load()
        
        #expect(loadedObject != nil)
        #expect(loadedObject == text)
    }
    
    @Test("Clear Codable should delete object with correct key")
    func testClearCodable() throws {
        
        let text: String = "Hello"
        try sut?.save(data: text)
        #expect(sut?.exists == true)
        
        try sut?.clear()
        
        #expect(sut?.exists == false)
    }
    
    // MARK: - Image Cache Tests
    @Test("Save Image Data should call storage with correct key")
    func testSaveImageData() throws {
        
        let imageData = Data("test_image".utf8)
        let imageKey = "rick_image"
        
        try sut?.saveCacheImageData(imageData, forKey: imageKey)
        
        #expect(mockStorage.lastSavedImageKey == imageKey)
        #expect(mockStorage.imageData[imageKey] == imageData)
    }
    
    @Test("Load Image Data should return correct data")
    func testLoadImageData() throws {
        let imageData = Data("test_image_2".utf8)
        let imageKey = "morty_image"
        
        try sut?.saveCacheImageData(imageData, forKey: imageKey)
        
        let loadedData = sut?.loadCachedImageData(forKey: imageKey)
        
        #expect(loadedData != nil)
        #expect(loadedData == imageData)
    }
    
    @Test("Delete image cache should delete image from storage")
    func deleteImageCache() throws {
        let imageData = Data("test_image_2".utf8)
        let imageKey = "morty_image"
        
        try sut?.saveCacheImageData(imageData, forKey: imageKey)
        try sut?.deleteImageCache(forKey: imageKey)
        
        #expect(sut?.imageCacheExists(forKey: imageKey) == false)
    }
    
    @Test("Image Cache Exists should return false when image is missing")
    func testImageCacheExists() {
        #expect(sut?.imageCacheExists(forKey: "non_existent_key") == false)
    }
}
