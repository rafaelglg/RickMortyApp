//
//  CharacterDetail.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 17/7/25.
//

import SwiftUI

struct CharacterDetail: View {
    
    let character: Character
    
    var body: some View {
        ScrollView {
            VStack {
                imageSection
                
                Text(character.name)
                    .font(.title)
                    .bold()
            }
        }
        .ignoresSafeArea()
    }
    
    var imageSection: some View {
        AsyncImage(
            url: character.imageURL,
            transaction: Transaction(animation: .spring)) { phase in
            
            switch phase {
            case .empty:
                Rectangle()
                    .frame(width: 450, height: 450)
                    .shimmerEffect()
                    .clipShape(.rect(cornerRadius: 25))
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 450, height: 450)
                    .clipShape(.rect(cornerRadius: 25))
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 440, height: 440)
                    .foregroundColor(.gray)
                    .clipShape(.rect(cornerRadius: 25))
            @unknown default:
                EmptyView()
            }
        }
    }
}

#Preview("Mock Character") {
    CharacterDetail(character: .mock)
}

#Preview("Empty Character") {
    CharacterDetail(character: .empty)
}
