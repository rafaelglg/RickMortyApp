//
//  CharacterView.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 17/7/25.
//

import SwiftUI

struct CharacterView: View {
    
    @State var viewModel: CharacterViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.loadState {
                case .initial, .loading:
                    placeholderView
                case .success(let characters):
                    successView(characters: characters)
                case .failure(let error):
                    errorView(error: error)
                }
            }
            .task(viewModel.getCharacter)
        }
    }
    
    var placeholderView: some View {
        List {
            ForEach(0..<12) {_ in
                CharacterCellPlaceholder()
            }
        }
    }
    
    func successView(characters: [Character]) -> some View {
        List {
            ForEach(characters) { character in
                NavigationLink(value: character) {
                    CharacterCell(character: character)
                }
            }
        }
        .navigationDestination(for: Character.self) { character in
            Text(character.created)
        }
    }
    
    func errorView(error: Error) -> some View {
        ContentUnavailableView("Could not load characters", systemImage: "exclamationmark.triangle.fill", description: Text(error.localizedDescription))
    }
}

#Preview("Character mock view") {
    let viewModelMock = CharacterViewModelMock(loadState: .success(Character.mocks))
    CharacterView(viewModel: viewModelMock)
}

#Preview("Loading view") {
    let viewModelMock = CharacterViewModelMock()
    CharacterView(viewModel: viewModelMock)
}

#Preview("Error view") {
    let viewModelMock = CharacterViewModelMock(loadState: .failure(APIError.invalidURL))
    CharacterView(viewModel: viewModelMock)
}
