//
//  InfoRow.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 21/7/25.
//

import SwiftUI

struct InfoRow: View {
    var emoji: String
    var label: String
    var value: String?

    var body: some View {
        if let value, !value.isEmpty {
            HStack(alignment: .top) {
                Text(emoji)
                    .frame(width: 30, alignment: .leading)

                Text(label)
                    .font(.headline)

                Text(value)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        } else {
            EmptyView()
        }
    }
}

#Preview {
    List {
        InfoRow(emoji: "👨‍👩‍👧‍👦", label: "Family", value: "Morty, Rick, Summer, Beth")
    }
}
