//
//  ImageLoaderViewodel.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 19/7/25.
//

import Foundation

@MainActor
protocol ImageLoaderViewodel {
    var url: URL { get }
    
    func loadImage() async -> Data?
}

@Observable
@MainActor
final class ImageLoaderViewodelImpl: ImageLoaderViewodel {
    let localPersistance: LocalPersistance
    let url: URL
    
    init(
        persistance: PersistanceServices,
        url: URL
    ) {
        self.localPersistance = persistance.local
        self.url = url
    }
    
    func loadImage() async -> Data? {
        let cacheKey = url.lastPathComponent
        
        if let data = localPersistance.loadCachedImageData(forKey: cacheKey) {
            return data
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            try localPersistance.saveCacheImageData(data, forKey: cacheKey)
            return data
        } catch {
            return nil
        }
    }
}
