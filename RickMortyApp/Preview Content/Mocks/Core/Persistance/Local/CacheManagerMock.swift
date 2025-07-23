//
//  CacheManagerMock.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 19/7/25.
//

import Foundation

final class CacheManagerMock: LocalPersistance, @unchecked Sendable {
    
    var cacheSize: Double = 0
    var sizeInCache: Double = 75.4
    
    var shouldReturnImageData: Data?
    var savedCacheImage: Data?
    var savedCacheKey: String?
    
    var saveImageError: Error?
    
    var exists: Bool = true
    
    func clearAll() throws { cacheSize = 0 }
    
    func load<T: Codable>() throws -> T? { nil }
    
    func save<T: Codable>(data: T) throws { }
    func clear() throws {
        cacheSize = 0
    }
    
    func getCacheSizeInMB() throws -> Double {
        cacheSize = sizeInCache
        return cacheSize
    }
    
    func loadCachedImageData(forKey key: String) -> Data? {
        shouldReturnImageData
    }
    
    func saveCacheImageData(_ data: Data, forKey key: String) throws {
        
        if let saveImageError {
            throw saveImageError
        }
        
        savedCacheImage = data
        savedCacheKey = key
    }
    
    func deleteImageCache(forKey key: String) throws { }
    
    func imageCacheExists(forKey key: String) -> Bool { true }
}
