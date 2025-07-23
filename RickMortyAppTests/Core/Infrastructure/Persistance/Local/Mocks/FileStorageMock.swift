//
//  FileStorageMock.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 22/7/25.
//

import Foundation
@testable import RickMortyApp

final class FileStorageMock: FileStorage, @unchecked Sendable {
    
    var codableData: [String: Data] = [:]
    var imageData: [String: Data] = [:]
    
    var deleteAppCacheFolderCalled = false
    var lastSavedCodableKey: String?
    var lastSavedImageKey: String?
    
    var shouldThrowOnSave = false
    var shouldThrowOnDelete = false
    
    func getAppCacheFolderURL() -> URL {
        deleteAppCacheFolderCalled = true
        return URL(fileURLWithPath: "/tmp/mock_cache")
    }
    
    func deleteAppCacheFolder() throws {
        if shouldThrowOnDelete { throw APIError.invalidURL }
        codableData.removeAll()
        imageData.removeAll()
        deleteAppCacheFolderCalled = true
    }
    
    func getCharacterCacheFolderURL(forKey key: String) -> URL {
        URL(string: "")!
    }
    
    func load<T: Codable>(forKey key: String) throws -> T? {
        guard let data = codableData[key] else { return nil }
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func save<T: Codable>(_ object: T, forKey key: String) throws {
        if shouldThrowOnSave { throw APIError.invalidURL }
        lastSavedCodableKey = key
        codableData[key] = try JSONEncoder().encode(object)
    }
    
    func deleteCache(forKey key: String) throws {
        if shouldThrowOnDelete { throw APIError.invalidURL }
        codableData[key] = nil
    }
    
    func exists(_ key: String) -> Bool {
        codableData[key] != nil
    }
    
    func saveImageData(_ data: Data, forKey key: String) throws {
        if shouldThrowOnSave { throw APIError.invalidURL }
        lastSavedImageKey = key
        imageData[key] = data
    }
    
    func loadImageData(forKey key: String) -> Data? {
        imageData[key]
    }
    
    func deleteImageCache(forKey key: String) throws {
        if shouldThrowOnDelete { throw APIError.invalidURL }
        imageData[key] = nil
    }
    
    func imageCacheExists(forKey key: String) -> Bool {
        imageData[key] != nil
    }
    
    func calculateSizeOfDirectory(at folderURL: URL) throws -> Int64 {
        let codableSize = codableData.values.reduce(0) { $0 + Int64($1.count) }
        let imageSize = imageData.values.reduce(0) { $0 + Int64($1.count) }
        return codableSize + imageSize
    }
}
