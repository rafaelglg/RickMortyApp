//
//  ImageLoader.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 19/7/25.
//

import SwiftUI

struct ImageLoader: View {
    
    @State var viewModel: ImageLoaderViewModel
    
    var title: String?
    var subtitle: String?
    
    init(
        viewModel: ImageLoaderViewModel,
        title: String? = nil,
        subtitle: String? = nil
    ) {
        self.viewModel = viewModel
        self.title = title
        self.subtitle = subtitle
        Task {
            await viewModel.loadImage()
        }
    }
    
    var body: some View {
        imageSection
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
            .scaledToFill()
            .shimmerEffect()
            .addingGradientBackgroundForText()
            .clipShape(.rect(cornerRadius: 15))
    }
    
    @ViewBuilder
    func loadImage(data: Data) -> some View {
        if let uiImage = UIImage(data: data) {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.gray.opacity(0.3))
                .overlay(
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .clipShape(.rect(cornerRadius: 15))
                        .transition(.opacity)
                        .animation(.bouncy, value: viewModel.url)
                )
                .overlay(alignment: .bottomLeading) {
                    if title != nil || subtitle != nil {
                        VStack(alignment: .leading, spacing: 4) {
                            if let title {
                                Text(title)
                                    .font(.largeTitle)
                                    .bold()
                            }
                            
                            if let subtitle {
                                Text(subtitle)
                                    .font(.subheadline)
                            }
                        }
                        .foregroundStyle(.white)
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .addingGradientBackgroundForText()
                    }
                }
                .clipShape(.rect(cornerRadius: 15))
        }
    }
    
    var imageDidNotLoad: some View {
        Button {
            
            withAnimation(.spring) {
                viewModel.isRetrying = true
            }
            
            Task {
                await viewModel.loadImage()
                viewModel.isRetrying = false
            }
            
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(uiColor: .systemGray5))
                
                VStack(spacing: 8) {
                    Image(systemName: "arrow.clockwise.circle.fill")
                        .font(.system(size: 25))
                        .foregroundColor(.secondary)
                        .rotationEffect(.degrees(viewModel.isRetrying ? 360 : 0))
                    
                    Text("Tap to retry")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.secondary)
                }
            }
        }
        .buttonStyle(.plain)
        .animation(viewModel.isRetrying ? .spring : nil, value: viewModel.isRetrying)
    }
}

#Preview("With title and subtitle") {
    List {
        let viewModel = ImageLoaderViewModelMock(useLoadImage: true)
        ImageLoader(
            viewModel: viewModel,
            title: "Some Title",
            subtitle: "Some subtitle"
        )
        .frame(
            maxWidth: .infinity,
            minHeight: 400,
            maxHeight: 600
        )
        .removeListRowFormatting()
    }
}

#Preview("Only image") {
    let viewModel = ImageLoaderViewModelMock(useLoadImage: true)
    ImageLoader(
        viewModel: viewModel
    )
    .frame(
        maxWidth: .infinity,
        minHeight: 200,
        maxHeight: 500
    )
    .task(viewModel.loadImage)
}

#Preview("Loading view") {
    ImageLoader(
        viewModel: ImageLoaderViewModelMock(
            loadState: .loading
        )
    )
    .frame(
        width: 300,
        height: 350
    )
}

#Preview("Image didn't load") {
    ImageLoader(
        viewModel: ImageLoaderViewModelMock(
            url: Character.empty.imageURL,
            loadState: .failure(APIError.invalidURL)
        )
    )
    .frame(
        width: 200,
        height: 200
    )
}
