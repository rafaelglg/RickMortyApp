//
//  ImageLoaderViewModelMock.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 20/7/25.
//

import Foundation

@Observable
@MainActor
final class ImageLoaderViewModelMock: ImageLoaderViewModel {
    
    let url: URL
    var loadState: LoadState<Data>
    var useLoadImage: Bool
    var isRetrying: Bool = false
    
    init(
        url: URL = Character.mock.imageURL,
        loadState: LoadState<Data> = .initial,
        useLoadImage: Bool = false
    ) {
        self.url = url
        self.loadState = loadState
        self.useLoadImage = useLoadImage
    }
    
    func loadImage() async {
        isRetrying = true
        
        defer { isRetrying = false }
        
        guard useLoadImage,
              let url = URL(string: "https://picsum.photos/500") else { return }
        
        do {
            try? await Task.sleep(for: .seconds(0.5))
            let (data, _) = try await URLSession.shared.data(from: url)
            self.loadState = .success(data)
        } catch {
            loadState = .failure(error)
        }
    }
}
