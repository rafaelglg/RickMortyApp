//
//  CharacterView.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 17/7/25.
//

import SwiftUI

struct CharacterView: View {
    
    let persistance: PersistanceServices
    @State var viewModel: CharacterViewModel
    
    init(
        viewModel: CharacterViewModel,
        persistance: PersistanceServices
    ) {
        self.viewModel = viewModel
        self.persistance = persistance
    }
    
    var body: some View {
        NavigationStack {
            content
        }
        .task(viewModel.getCharacters)
    }
    
    @ViewBuilder
    var content: some View {
        List {
            switch viewModel.loadState {
            case .initial, .loading:
                placeholderView
            case .success:
                successView()
            case .failure(let error):
                errorView(error: error)
            }
        }
        .searchable(text: .constant(""))
        .navigationTitle("Characters")
        .scrollIndicators(.hidden)
        .navigationDestination(for: Character.self) { character in
            CharacterDetail(character: character)
        }
    }
    
    var placeholderView: some View {
        ForEach(0..<12) {_ in
            CharacterCellPlaceholder()
        }
    }
    
    @ViewBuilder
    func successView() -> some View {
        ForEach(viewModel.characters) { character in
            NavigationLink(value: character) {
                CharacterCell(
                    character: character,
                    persistance: persistance
                )
                .onAppear {
                    if viewModel.canLoadMore && viewModel.hasReachedEnd(of: character) {
                        Task(operation: viewModel.loadMoreCharacters)
                    }
                }
            }
        }
        loadMoreSection
    }
    
    @ViewBuilder
    var loadMoreSection: some View {
        if viewModel.isLoadingMore {
            ProgressView("Loading...")
                .frame(maxWidth: .infinity)
                .frame(height: 120)
                .removeListRowFormatting()
                .id(UUID()) // To force the view to not reuse the same view from before, instead created new one every time
        }
    }
    
    func errorView(error: Error) -> some View {
        VStack {
            ContentUnavailableView("Could not load characters", systemImage: "exclamationmark.triangle.fill", description: Text(error.localizedDescription))
            
            Button {
                Task {
                    await viewModel.getCharacters()
                }
            } label: {
                Text("Reload")
                    .frame(width: 150, height: 40)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
        }
        .removeListRowFormatting()
    }
}

#Preview("Character mock view") {
    let viewModelMock = CharacterViewModelMock(loadState: .success(Character.mocks))
    CharacterView(
        viewModel: viewModelMock,
        persistance: MockPersistanceServices()
    )
}

#Preview("Loading view") {
    let viewModelMock = CharacterViewModelMock()
    CharacterView(
        viewModel: viewModelMock,
        persistance: MockPersistanceServices()
    )
}

#Preview("Error view") {
    let viewModelMock = CharacterViewModelMock(loadState: .failure(APIError.invalidURL))
    CharacterView(
        viewModel: viewModelMock,
        persistance: MockPersistanceServices()
    )
}
