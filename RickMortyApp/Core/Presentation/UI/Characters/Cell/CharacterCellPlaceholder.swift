//
//  CharacterCellPlaceholder.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 18/7/25.
//

import SwiftUI

struct CharacterCellPlaceholder: View {
        
    var body: some View {
        HStack {
            imageSection
            infoSection
        }
    }
    
    var imageSection: some View {
        Rectangle()
            .frame(width: 120, height: 120)
            .shimmerEffect()
            .clipShape(.rect(cornerRadius: 10))
    }
    
    var infoSection: some View {
        VStack(alignment: .leading) {
            Rectangle()
                .frame(width: 110, height: 20)
                .shimmerEffect()
                .clipShape(.rect(cornerRadius: 5))

            Rectangle()
                .frame(width: 60, height: 20)
                .shimmerEffect()
                .clipShape(.rect(cornerRadius: 5))
        }
    }
}

#Preview {
    CharacterCellPlaceholder()
}
