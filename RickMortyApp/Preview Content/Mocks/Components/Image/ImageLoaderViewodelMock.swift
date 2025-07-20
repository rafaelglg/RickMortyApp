//
//  ImageLoaderViewodelMock.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 20/7/25.
//

import Foundation

@Observable
@MainActor
final class ImageLoaderViewodelMock: ImageLoaderViewModel {
    
    let url: URL
    var loadState: LoadState<Data>
    var useLoadImage: Bool
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
