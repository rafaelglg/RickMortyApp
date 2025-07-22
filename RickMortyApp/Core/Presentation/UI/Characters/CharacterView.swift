//
//  CharacterView.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 17/7/25.
//

import SwiftUI

struct CharacterView: View {
    
    let dependencies: Dependencies
    let persistance: PersistanceServices
    @State var viewModel: CharacterViewModel
    
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
        .searchable(text: $viewModel.searchText, prompt: "Search characters")
        .navigationTitle("Characters")
        .scrollIndicators(.hidden)
        .navigationDestination(for: Character.self) { character in
            CharacterDetail(
                character: character,
                persistance: persistance,
                viewModel: dependencies.makeCharacterDetailViewModel()
            )
        }
        .onChange(of: viewModel.searchText) { _, newValue in
            Task {
                await viewModel.searchCharacters(query: newValue)
            }
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
        } else if let error = viewModel.loadMoreError {
            VStack(spacing: -10) {
                ContentUnavailableView(
                    "Error loading more characters",
                    systemImage: "exclamationmark.triangle.fill",
                    description: Text(
                        error.localizedDescription
                    )
                )
                
                Button("Retry") {
                    Task {
                        await viewModel.getCharacters()
                        await viewModel.loadMoreCharacters()
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.top)
            .removeListRowFormatting()
        }
    }
    
    @ViewBuilder
    func errorView(error: Error) -> some View {
        if !viewModel.searchText.isEmpty {
            ContentUnavailableView(
                "No Results Found",
                systemImage: "magnifyingglass",
                description: Text("There are no characters matching your search for \"\(viewModel.searchText)\". Try a different name.")
            )
            .removeListRowFormatting()
            
        } else if viewModel.characters.isEmpty {
            VStack {
                ContentUnavailableView(
                    "Could not load characters",
                    systemImage: "exclamationmark.triangle.fill",
                    description: Text(
                        error.localizedDescription
                    )
                )
                
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
}

#Preview("Character mock view") {
    @Previewable @State var searchText: String = ""
    let viewModelMock = CharacterViewModelMock(
        loadState: .success(
            Character.mocks
        ),
        searchText: searchText
    )
    CharacterView(
        dependencies: DependenciesMock(),
        persistance: MockPersistanceServices(),
        viewModel: viewModelMock
    )
    .onChange(of: searchText) { _, newValue in
        Task {
           await viewModelMock.searchCharacters(query: newValue)
        }
    }
}

#Preview("Character error in list") {
    let viewModelMock = CharacterViewModelMock(loadState: .success(Character.mocks), loadMoreError: APIError.invalidURL)
    CharacterView(
        dependencies: DependenciesMock(),
        persistance: MockPersistanceServices(),
        viewModel: viewModelMock
    )
}

#Preview("Loading view") {
    let viewModelMock = CharacterViewModelMock()
    CharacterView(
        dependencies: DependenciesMock(),
        persistance: MockPersistanceServices(),
        viewModel: viewModelMock
    )
}

#Preview("Error view") {
    let viewModelMock = CharacterViewModelMock(loadState: .failure(APIError.invalidURL))
    CharacterView(
        dependencies: DependenciesMock(),
        persistance: MockPersistanceServices(),
        viewModel: viewModelMock
    )
}
