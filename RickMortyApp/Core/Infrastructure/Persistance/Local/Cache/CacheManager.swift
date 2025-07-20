//
//  LocalPersistance.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 18/7/25.
//

import Foundation

struct CacheManager: LocalPersistance {
    let storage: FileStorage
    let dataCacheKey = "characters_info"
    let imageCacheKey = "characters_image"
    
    init(storage: FileStorage) {
        self.storage = storage
    }
    
    // MARK: - Shared
    
    func clearAll() throws {
        try storage.deleteAppCacheFolder()
    }
    
    func getCacheSizeInMB() throws -> Double {
        let url = storage.getAppCacheFolderURL()
        let cacheFolderSize = try storage.calculateSizeOfDirectory(at: url)
        let totalSizeInMB = Double(cacheFolderSize) / (1024.0 * 1024.0)
        
        return totalSizeInMB
    }
    
    // MARK: - Objects cache
    var exists: Bool {
        storage
            .exists(dataCacheKey)
    }
    
    func load<T: Codable>() throws -> T? {
        try storage
            .load(forKey: dataCacheKey)
    }
    
    func save<T: Codable>(data: T) throws {
        try storage
            .save(data, forKey: dataCacheKey)
    }
    
    func clear() throws {
        try storage
            .deleteCache(forKey: dataCacheKey)
    }
    
    // MARK: - Image Cache
    func loadCachedImageData(forKey key: String) -> Data? {
        storage.loadImageData(forKey: key)
    }
    
    func saveCacheImageData(_ data: Data, forKey key: String) throws {
        try storage.saveImageData(data, forKey: key)
    }
    
    func deleteImageCache(forKey key: String) throws {
        try storage.deleteImageCache(forKey: key)
    }
    
    func imageCacheExists(forKey key: String) -> Bool {
        storage.imageCacheExists(forKey: key)
    }
}
