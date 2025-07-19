//
//  CharacterCell.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 16/7/25.
//

import SwiftUI

struct CharacterCell: View {
    
    let character: Character
    let persistance: PersistanceServices
    
    init(
        character: Character,
        persistance: PersistanceServices
    ) {
        self.character = character
        self.persistance = persistance
    }
    
    var body: some View {
        HStack(spacing: 20) {
            imageSection
            infoSection
        }
    }
    
    var imageSection: some View {
        ImageLoader(
            viewModel: ImageLoaderViewodelImpl(
                persistance: persistance,
                url: character.imageURL
            ),
            size: CGSize(
                width: 120,
                height: 120
            )
        )
    }
    
    var infoSection: some View {
        VStack(alignment: .leading) {
            Text(character.name)
                .lineLimit(1)
                .allowsTightening(true)
                .minimumScaleFactor(0.6)
                .truncationMode(.tail)
                .font(.headline)
            Text(character.gender)
                .font(.callout)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview("Mock") {
    List {
        CharacterCell(
            character: .mock,
            persistance: MockPersistanceServices()
        )
    }
}

#Preview("W/out information") {
    List {
        CharacterCell(
            character: .empty,
            persistance: MockPersistanceServices()
        )
    }
}

#Preview("W/out picture") {
    List {
        CharacterCell(
            character: .mocks[2],
            persistance: MockPersistanceServices()
        )
    }
}
