//
//  UIScreen+EXT.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 20/7/25.
//

import UIKit

extension UIScreen {
    static var current: UIScreen {
        UIWindow.current?.screen ?? UIScreen()
    }
}
