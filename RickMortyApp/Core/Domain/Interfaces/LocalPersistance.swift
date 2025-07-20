//
//  LocalPersistance.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 18/7/25.
//

import Foundation

protocol LocalPersistance: Sendable {
    
    var exists: Bool { get }
    
    func clearAll() throws
    func getCacheSizeInMB() throws -> Double
    
    func load<T: Codable>() throws -> T?
    func save<T: Codable>(data: T) throws
    func clear() throws
    
    func loadCachedImageData(forKey key: String) -> Data?
    func saveCacheImageData(_ data: Data, forKey key: String) throws
    func deleteImageCache(forKey key: String) throws
    func imageCacheExists(forKey key: String) -> Bool
}
