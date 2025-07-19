//
//  FileManager+EXT.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 18/7/25.
//

import Foundation

extension FileManager {
    
    /// Returns the URL for the app-specific cache folder within the user's caches directory.
    ///
    /// This method constructs a subdirectory named `cacheRickMortyApp` inside the system's
    /// caches directory. If the directory does not exist, it is created automatically,
    /// including any intermediate folders needed.
    ///
    /// - Returns: A `URL` pointing to the `cacheRickMortyApp` folder inside the user's caches directory.
    func getAppCacheFolderURL() -> URL {
        let url = urls(for: .cachesDirectory, in: .userDomainMask).first!
        let appCacheURL = url.appending(path: "cacheRickMortyApp", directoryHint: .isDirectory)
        
        if !fileExists(atPath: appCacheURL.path) {
            try? createDirectory(at: appCacheURL, withIntermediateDirectories: true)
        }
        
        return appCacheURL
    }
    
    func deleteAppCacheFolder() throws {
        let url = getAppCacheFolderURL()
        
        if fileExists(atPath: url.path()) {
            try removeItem(at: url)
        }
    }
    
    /// Returns the URL for a cache file associated with the given key.
    ///
    /// - Parameter key: The identifier used to create the cache file name.
    /// - Returns: A `URL` pointing to the cache file in the user's caches directory.
    func getCacheURL(forKey key: String) -> URL {
        let folderURL = getAppCacheFolderURL()
            .appending(path: "CharacterCache", directoryHint: .isDirectory)
        
        if !fileExists(atPath: folderURL.path) {
            try? createDirectory(at: folderURL, withIntermediateDirectories: true)
        }
        
        print(folderURL.path())
        return folderURL.appendingPathComponent(key)
    }
    
    /// Saves a Codable object to the caches directory under the specified key.
    ///
    /// - Parameters:
    ///   - object: The Codable object to save.
    ///   - key: The key used to identify the cached file.
    /// - Throws: Throws an error if encoding or writing to disk fails.
    func save<T: Codable>(_ object: T, forKey key: String) throws {
        let url = getCacheURL(forKey: key)
        let data = try JSONEncoder().encode(object)
        try data.write(to: url, options: .atomic)
    }
    
    /// Loads and decodes a Codable object from the caches directory.
    ///
    /// - Parameter key: The key identifying the cached file.
    /// - Returns: The decoded object if the file exists and decoding succeeds, otherwise `nil`.
    /// - Throws: Throws an error if reading or decoding fails.
    func load<T: Codable>(forKey key: String) throws -> T? {
        let url = getCacheURL(forKey: key)
        guard fileExists(atPath: url.path()) else { return nil }
        
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func deleteCache(forKey key: String) throws {
        let url = getCacheURL(forKey: key)
        
        if fileExists(atPath: url.path()) {
            try removeItem(at: url)
        }
    }
    
    /// Checks whether a cached file exists for the given key.
    ///
    /// - Parameter key: The key identifying the cached file.
    /// - Returns: `true` if the file exists, otherwise `false`.
    func exists(_ key: String) -> Bool {
        let fileURL = getCacheURL(forKey: key)
        return fileExists(atPath: fileURL.path())
    }
    
    // MARK: - Image Cache Support
    func getImageFolderURL() -> URL {
        let folderURL = getAppCacheFolderURL()
            .appending(path: "ImageCache", directoryHint: .isDirectory)

        if !fileExists(atPath: folderURL.path) {
            try? createDirectory(at: folderURL, withIntermediateDirectories: true)
        }

        return folderURL
    }
    
    func getImageCacheURL(forKey key: String) -> URL {
        return getImageFolderURL().appendingPathComponent(key)
    }
    
    /// Saves raw image data to disk cache.
    /// - Parameters:
    ///   - data: Image binary data.
    ///   - key: The identifier used to create the file name.
    /// - Throws: Throws if writing data fails.
    func saveImageData(_ data: Data, forKey key: String) throws {
        let url = getImageCacheURL(forKey: key)
        try data.write(to: url, options: .atomic)
    }
    
    /// Loads image data from disk cache.
    /// - Parameter key: The key identifying the image file.
    /// - Returns: The data if the file exists, else `nil`.
    func loadImageData(forKey key: String) -> Data? {
        let url = getImageCacheURL(forKey: key)
        guard fileExists(atPath: url.path) else { return nil }
        return try? Data(contentsOf: url)
    }
    
    /// Deletes cached image data for given key.
    /// - Parameter key: The key identifying the image file.
    /// - Throws: Throws if deletion fails.
    func deleteImageCache(forKey key: String) throws {
        let url = getImageCacheURL(forKey: key)
        if fileExists(atPath: url.path) {
            try removeItem(at: url)
        }
    }
    
    /// Checks if cached image exists for given key.
    /// - Parameter key: The key identifying the image file.
    /// - Returns: `true` if file exists, else `false`.
    func imageCacheExists(forKey key: String) -> Bool {
        let url = getImageCacheURL(forKey: key)
        return fileExists(atPath: url.path)
    }
    
    // MARK: - Size of File
    
    /// Calculates the total size of all files within a specified cache directory on disk.
    ///
    /// This method recursively enumerates all files within the given folder URL and sums their
    /// individual file sizes to provide an accurate total.
    ///
    /// - Parameter folderURL: The URL of the folder to measure.
    /// - Returns: The total size of all files in bytes as an `Int64`.
    /// - Throws: An error if the directory contents cannot be read.
    func calculateSizeOfDirectory(at folderURL: URL) throws -> Int64 {
        guard let enumerator = self.enumerator(at: folderURL, includingPropertiesForKeys: [.fileSizeKey]) else {
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
