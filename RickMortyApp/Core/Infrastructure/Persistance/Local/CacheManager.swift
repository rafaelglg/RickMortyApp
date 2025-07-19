//
//  LocalPersistance.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 18/7/25.
//

import Foundation

struct CacheManager: LocalPersistance {
    let dataCacheKey = "characters_info"
    let imageCacheKey = "characters_image"
    
    // MARK: - Shared
    
    func clearAll() throws {
        try FileManager.default.deleteAppCacheFolder()
    }
    
    func getCacheSizeInMB() throws -> Double {
        let url = FileManager.default.getAppCacheFolderURL()
        let cacheFolderSize = try FileManager.default.calculateSizeOfDirectory(at: url)
        let totalSizeInMB = Double(cacheFolderSize) / (1024.0 * 1024.0)
        
        return totalSizeInMB
    }
    
    // MARK: - Objects cache
    var exists: Bool {
        FileManager.default
            .exists(dataCacheKey)
    }
    
    func load<T: Codable>() throws -> T? {
        try FileManager.default
            .load(forKey: dataCacheKey)
    }
    
    func save<T: Codable>(data: T) throws {
        try FileManager.default
            .save(data, forKey: dataCacheKey)
    }
    
    func clear() throws {
        try FileManager.default
            .deleteCache(forKey: dataCacheKey)
    }
    
    // MARK: - Image Cache
    func loadCachedImageData(forKey key: String) -> Data? {
        FileManager.default.loadImageData(forKey: key)
    }
    
    func saveCacheImageData(_ data: Data, forKey key: String) throws {
        try FileManager.default.saveImageData(data, forKey: key)
    }
    
    func deleteImageCache(forKey key: String) throws {
        try FileManager.default.deleteImageCache(forKey: key)
    }
    
    func imageCacheExists(forKey key: String) -> Bool {
        FileManager.default.imageCacheExists(forKey: key)
    }
}
