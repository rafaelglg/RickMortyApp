//
//  UIWindow+EXT.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 20/7/25.
//

import UIKit

extension UIWindow {
    static var current: UIWindow? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first(where: \.isKeyWindow)
    }
}
