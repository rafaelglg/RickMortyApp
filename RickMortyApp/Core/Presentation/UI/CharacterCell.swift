//
//  CharacterCell.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 16/7/25.
//

import SwiftUI

struct CharacterCell: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    CharacterCell()
}
