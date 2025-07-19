//
//  ImageLoader.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 19/7/25.
//

import SwiftUI

struct ImageLoader: View {
    
    let size: CGSize?
    
    @State var viewModel: ImageLoaderViewodel
    @State var uiImage: UIImage?
    
    init(
        viewModel: ImageLoaderViewodel,
        size: CGSize? = nil
    ) {
        self.viewModel = viewModel
        self.size = size
    }
    
    var body: some View {
        imageSection
            .task {
                await loadImage()
            }
    }
    
    @ViewBuilder
    var imageSection: some View {
        if let uiImage {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .clipShape(.rect(cornerRadius: 20))
                .transition(.opacity)
                .animation(.bouncy, value: viewModel.url)
                .frame(
                    width: size?.width,
                    height: size?.height
                )
        } else {
            Rectangle()
                .frame(
                    width: size?.width,
                    height: size?.height
                )
                .shimmerEffect()
                .clipShape(.rect(cornerRadius: 20))
        }
    }
    
    func loadImage() async {
        if let data = await viewModel.loadImage() {
            let image = UIImage(data: data)
            self.uiImage = image
        }
    }
}

#Preview {
    ImageLoader(
        viewModel: ImageLoaderViewodelImpl(
            persistance: MockPersistanceServices(),
            url: Character.mock.imageURL
        ),
        size: CGSize(width: 350, height: 350)
    )
}

#Preview("Loading view") {
    ImageLoader(
        viewModel: ImageLoaderViewodelImpl(
            persistance: MockPersistanceServices(),
            url: Character.empty.imageURL
        ),
        size: CGSize(width: 350, height: 350)
    )
}
