//
//  ImageLoader.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 19/7/25.
//

import SwiftUI

struct ImageLoader: View {
    
    let size: CGSize?
    
    @State var viewModel: ImageLoaderViewModel
    @State var uiImage: UIImage?
    
    init(
        viewModel: ImageLoaderViewModel,
        size: CGSize? = nil
    ) {
        self.viewModel = viewModel
        self.size = size
    }
    
    var body: some View {
        imageSection
            .task(viewModel.loadImage)
            .onChange(of: viewModel.loadState) { _, newValue in
                if case let .success(data) = newValue {
                    self.uiImage = UIImage(data: data)
                }
            }
    }
    
    @ViewBuilder
    var imageSection: some View {
        switch viewModel.loadState {
        case .initial, .loading:
            placeholderImageView
        case .success(let imageData):
            loadImage(data: imageData)
        case .failure:
            imageDidNotLoad
        }
    }
    
    var placeholderImageView: some View {
        Rectangle()
            .frame(
                width: size?.width,
                height: size?.height
            )
            .shimmerEffect()
            .clipShape(.rect(cornerRadius: 20))
    }
    
    @ViewBuilder
    func loadImage(data: Data) -> some View {
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
        }
    }
    
    var imageDidNotLoad: some View {
        Image(systemName: "photo")
            .resizable()
            .scaledToFill()
            .frame(
                width: size?.width,
                height: size?.height
            )
            .foregroundColor(.gray)
            .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    let viewModel = ImageLoaderViewodelMock(useLoadImage: true)
    ImageLoader(
        viewModel: viewModel,
        size: CGSize(width: 350, height: 350)
    )
    .task(viewModel.loadImage)
}

#Preview("Loading view") {
    ImageLoader(
        viewModel: ImageLoaderViewodelMock(
            loadState: .loading
        ), size: CGSize(width: 350, height: 350)
    )
}

#Preview("W/out image view") {
    ImageLoader(
        viewModel: ImageLoaderViewodelMock(
            url: Character.empty.imageURL,
            loadState: .failure(APIError.invalidURL)
        ), size: CGSize(width: 350, height: 350)
    )
}
