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
    
    var body: some View {
        ScrollView {
            VStack {
                imageSection
                
                Text(character.name)
                    .font(.title)
                    .bold()
            }
        }
        .clipped()
    }
    
    var imageSection: some View {
        ImageLoader(
            viewModel: ImageLoaderViewodelImpl(
                persistance: persistance,
                url: character.imageURL
            ),
            size: CGSize(
                width: 450,
                height: 450
            )
        )
    }
}

#Preview("Mock Character") {
    CharacterDetail(
        character: .mock,
        persistance: MockPersistanceServices()
    )
}

#Preview("Empty Character") {
    CharacterDetail(
        character: .empty,
        persistance: MockPersistanceServices()
    )
}
