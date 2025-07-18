//
//  CharacterCell.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 16/7/25.
//

import SwiftUI

struct CharacterCell: View {
    
    let character: Character
    
    var body: some View {
        HStack(spacing: 20) {
            imageSection
            infoSection
        }
    }
    
    var imageSection: some View {
        VStack {
            AsyncImage(url: character.imageURL) { image in
                image.resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .clipShape(.rect(cornerRadius: 20))
                    .transition(.opacity)
                    .animation(.bouncy, value: character.imageURL)
            } placeholder: {
                Rectangle()
                    .frame(width: 120, height: 120)
                    .shimmerEffect()
                    .clipShape(.rect(cornerRadius: 10))
            }
        }
    }
    
    var infoSection: some View {
        VStack(alignment: .leading) {
            Text(character.name)
                .font(.headline)
            Text(character.gender)
                .font(.callout)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview("Mock") {
    List {
        CharacterCell(character: .mock)
    }
}

#Preview("W/out information") {
    List {
        CharacterCell(character: .empty)
    }
}

#Preview("W/out picture") {
    List {
        CharacterCell(character: .mocks[2])
    }
}
