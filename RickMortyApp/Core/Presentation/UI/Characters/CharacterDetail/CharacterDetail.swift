//
//  CharacterDetail.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 17/7/25.
//

import SwiftUI

struct CharacterDetail: View {
    
    let character: Character
    let persistance: PersistanceServices
    
    @State var viewModel: CharacterDetailViewModel
    
    var body: some View {
        List {
            Group {
                imageSection
                basicInfoSection
                episodesSection
            }
        }
        .task {
            await viewModel.getEpisodeDetails(character: character)
        }
    }
    
    var imageSection: some View {
        ImageLoader(
            viewModel: ImageLoaderViewModelImpl(
                persistance: persistance,
                url: character.imageURL
            ),
            title: character.name,
            subtitle: character.species
        )
        .frame(
            maxWidth: .infinity,
            minHeight: 400,
            maxHeight: 500
        )
        .removeListRowFormatting()
        .padding()
    }
    
    var basicInfoSection: some View {
        Section {
            InfoRow(emoji: "🩺", label: "Status", value: character.status)
            InfoRow(emoji: "🧬", label: "Species", value: character.species)
            
            if !character.type.isEmpty {
                InfoRow(emoji: "🧪", label: "Type", value: character.type)
            }
            
            InfoRow(emoji: "⚥", label: "Gender", value: character.gender)
            InfoRow(emoji: "🌍", label: "Origin", value: character.origin.name)
            InfoRow(emoji: "📍", label: "Location", value: character.location.name)
            InfoRow(emoji: "📅", label: "Created", value: character.formattedCreatedDate)
        }
    }
    
    @ViewBuilder
    var episodesSection: some View {
        if !viewModel.episode.isEmpty {
            Section {
                ForEach(viewModel.episode, id: \.self) { episode in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(episode.name)
                                .font(.headline)
                                .lineLimit(2)
                                .minimumScaleFactor(0.5)
                                .frame(width: 200, alignment: .leading)
                                .truncationMode(.tail)
                            
                            Text(episode.episode)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                        }
                        Spacer()
                        
                        Text(episode.airDate)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .frame(width: 110, alignment: .trailing)
                    }
                }
            } header: {
                Text("Episodes")
            } footer: {
                Text("Episodes in which the character appeared.")
            }
        }
    }
}

#Preview("Mock Character") {
    NavigationStack {
        CharacterDetail(
            character: .mock,
            persistance: MockPersistanceServices(),
            viewModel: CharacterDetailViewModelMock()
        )
    }
}

#Preview("Empty Character") {
    CharacterDetail(
        character: .empty,
        persistance: MockPersistanceServices(),
        viewModel: CharacterDetailViewModelMock(episode: [])
    )
}
