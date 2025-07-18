//
//  View+EXT.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 17/7/25.
//

import SwiftUI

extension View {
    func shimmerEffect(
        firstColor: Color = Color(uiColor: UIColor.systemGray5),
        secondColor: Color = Color(uiColor: UIColor.systemGray6),
        thirdColor: Color = Color(uiColor: UIColor.systemGray5)
    ) -> some View {
        self.modifier(
            ShimmerEffect(
                firstColor: firstColor,
                secondColor: secondColor,
                thirdColor: thirdColor
            )
        )
    }
}
