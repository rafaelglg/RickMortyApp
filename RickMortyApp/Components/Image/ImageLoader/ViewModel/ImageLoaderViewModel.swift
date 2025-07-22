//
//  ImageLoaderViewModel.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 19/7/25.
//

import Foundation

@MainActor
protocol ImageLoaderViewModel: Sendable {
    var url: URL { get }
    var loadState: LoadState<Data> { get }
    var isRetrying: Bool { get set }
    
    func loadImage() async
}

@Observable
@MainActor
final class ImageLoaderViewModelImpl: ImageLoaderViewModel {
    let localPersistance: LocalPersistance
    let url: URL
    
    var loadState: LoadState<Data> = .initial
    var isRetrying: Bool = false
    
    init(
        persistance: PersistanceServices,
        url: URL
    ) {
        self.localPersistance = persistance.local
        self.url = url
    }
    
    func loadImage() async {
        loadState = .loading
        
        let cacheKey = url.lastPathComponent
        
        if let data = localPersistance.loadCachedImageData(forKey: cacheKey) {
            loadState = .success(data)
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            try localPersistance.saveCacheImageData(data, forKey: cacheKey)
            loadState = .success(data)
        } catch {
            loadState = .failure(error)
        }
    }
}
