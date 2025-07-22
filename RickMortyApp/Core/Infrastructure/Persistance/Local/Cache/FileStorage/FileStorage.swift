//
//  FileStorage.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 20/7/25.
//

import Foundation

protocol FileStorage: Sendable {
    
     func getAppCacheFolderURL() -> URL
     func deleteAppCacheFolder() throws
     func getCharacterCacheFolderURL(forKey key: String) -> URL
     func save<T: Codable>(_ object: T, forKey key: String) throws
     func load<T: Codable>(forKey key: String) throws -> T?
     func deleteCache(forKey key: String) throws
     func exists(_ key: String) -> Bool
     func saveImageData(_ data: Data, forKey key: String) throws
     func loadImageData(forKey key: String) -> Data?
     func deleteImageCache(forKey key: String) throws
     func imageCacheExists(forKey key: String) -> Bool
     func calculateSizeOfDirectory(at folderURL: URL) throws -> Int64
}

struct FileStorageImpl: FileStorage {
    
    let fileManager = FileManager.default
    
    // MARK: - Main folder cacheRickMortyApp
    
    /// Returns the URL of a specific subfolder inside the app's cache folder.
    ///
    /// This method checks if the requested folder exists inside the app-specific
    /// cache directory. If the folder does not exist, it attempts to create it,
    /// including any intermediate directories as needed.
    ///
    /// - Parameter folder: An enum value representing the desired cache subfolder.
    /// - Returns: The URL pointing to the requested cache subfolder.
    /// - Note: If the folder creation fails, the function will silently ignore the error.
    ///         Consider handling errors explicitly if needed.
    func folderURL(named folder: FileStorageFolder) -> URL {
        let baseURL = getAppCacheFolderURL()
        let folderURL = baseURL.appending(path: folder.name, directoryHint: .isDirectory)
        
        if !fileManager.fileExists(atPath: folderURL.path()) {
            try? fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true)
        }
        
        return folderURL
    }
    
    /// Returns the URL of the app-specific cache folder inside the user's caches directory.
    func getAppCacheFolderURL() -> URL {
        let url = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let appCacheURL = url.appending(path: "cacheRickMortyApp", directoryHint: .isDirectory)
        
        if !fileManager.fileExists(atPath: appCacheURL.path) {
            try? fileManager.createDirectory(at: appCacheURL, withIntermediateDirectories: true)
        }
        return appCacheURL
    }
    
    /// Deletes the entire app cache folder.
    /// - Throws: An error if deletion fails.
    func deleteAppCacheFolder() throws {
        let url = getAppCacheFolderURL()
        
        if fileManager.fileExists(atPath: url.path()) {
            try fileManager.removeItem(at: url)
        }
    }
    
    /// Returns the file URL for a cached object associated with a key.
    /// - Parameter key: The key identifying the cached file.
    func getCharacterCacheFolderURL(forKey key: String) -> URL {
        folderURL(named: .characterCache)
            .appendingPathComponent(key)
    }
    
    /// Saves a Codable object to disk for the specified key.
    /// - Parameters:
    ///   - object: The Codable object to save.
    ///   - key: The key used as file identifier.
    /// - Throws: If encoding or writing fails.
    func save<T: Codable>(_ object: T, forKey key: String) throws {
        let url = getCharacterCacheFolderURL(forKey: key)
        let data = try JSONEncoder().encode(object)
        try data.write(to: url, options: .atomic)
    }
    
    /// Loads and decodes a Codable object from disk for the specified key.
    /// - Parameter key: The key identifying the cached file.
    /// - Returns: The decoded object or nil if file doesn't exist.
    /// - Throws: If reading or decoding fails.
    func load<T: Codable>(forKey key: String) throws -> T? {
        let url = getCharacterCacheFolderURL(forKey: key)
        guard fileManager.fileExists(atPath: url.path()) else { return nil }
        
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    /// Deletes the cached file for the given key.
    /// - Parameter key: The key identifying the cached file.
    /// - Throws: If deletion fails.
    func deleteCache(forKey key: String) throws {
        let url = getCharacterCacheFolderURL(forKey: key)
        
        if fileManager.fileExists(atPath: url.path()) {
            try fileManager.removeItem(at: url)
        }
    }
    
    /// Checks if a cached file exists for the given key.
    /// - Parameter key: The key identifying the cached file.
    /// - Returns: True if the file exists, false otherwise.
    func exists(_ key: String) -> Bool {
        let fileURL = getCharacterCacheFolderURL(forKey: key)
        return fileManager.fileExists(atPath: fileURL.path())
    }
    
    // MARK: - Image Cache Support
    func getImageCacheFolderURL(forKey key: String) -> URL {
        folderURL(named: .imageCache)
            .appending(path: key)
    }
    
    /// Saves raw image data to disk cache.
    /// - Parameters:
    ///   - data: The image data to save.
    ///   - key: The key used as file identifier.
    /// - Throws: If writing fails.
    func saveImageData(_ data: Data, forKey key: String) throws {
        let url = getImageCacheFolderURL(forKey: key)
        try data.write(to: url, options: .atomic)
    }
    
    /// Loads image data from disk cache for the specified key.
    /// - Parameter key: The key identifying the image file.
    /// - Returns: The image data if exists, nil otherwise.
    func loadImageData(forKey key: String) -> Data? {
        let url = getImageCacheFolderURL(forKey: key)
        guard fileManager.fileExists(atPath: url.path) else { return nil }
        return try? Data(contentsOf: url)
    }
    
    /// Deletes the cached image file for the given key.
    /// - Parameter key: The key identifying the cached image.
    /// - Throws: If deletion fails.
    func deleteImageCache(forKey key: String) throws {
        let url = getImageCacheFolderURL(forKey: key)
        if fileManager.fileExists(atPath: url.path) {
            try fileManager.removeItem(at: url)
        }
    }
    
    /// Checks if a cached image file exists for the given key.
    /// - Parameter key: The key identifying the image file.
    /// - Returns: True if the image file exists, false otherwise.
    func imageCacheExists(forKey key: String) -> Bool {
        let url = getImageCacheFolderURL(forKey: key)
        return fileManager.fileExists(atPath: url.path)
    }
    
    // MARK: - Helpers
    
    /// Calculates the total size in bytes of all files inside the given folder.
    /// - Parameter folderURL: The URL of the folder to measure.
    /// - Returns: The total size in bytes.
    /// - Throws: If folder contents cannot be read.
    func calculateSizeOfDirectory(at folderURL: URL) throws -> Int64 {
        guard let enumerator = fileManager.enumerator(at: folderURL, includingPropertiesForKeys: [.fileSizeKey]) else {
            return 0
        }
        
        var totalSize: Int64 = 0
        
        for case let fileURL as URL in enumerator {
            let resourceValues = try fileURL.resourceValues(forKeys: [.fileSizeKey])
            totalSize += Int64(resourceValues.fileSize ?? 0)
        }
        
        return totalSize
    }
}
