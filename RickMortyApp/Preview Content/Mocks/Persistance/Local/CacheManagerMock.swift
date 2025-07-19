//
//  CacheManagerMock.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 19/7/25.
//

import Foundation

struct CacheManagerMock: LocalPersistance {
    var exists: Bool = true
    
    func clearAll() throws { }
    
    func load<T: Codable>() throws -> T? { nil }
    
    func save<T: Codable>(data: T) throws { }
    func clear() throws { }
    func getCacheSizeInMB() throws -> Double { 75.4 }
    
    func loadCachedImageData(forKey key: String) -> Data? { nil }
    
    func saveCacheImageData(_ data: Data, forKey key: String) throws { }
    
    func deleteImageCache(forKey key: String) throws { }
    
    func imageCacheExists(forKey key: String) -> Bool { true }
}
