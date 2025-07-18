//
//  RickMortyAppApp.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 16/7/25.
//

import SwiftUI

@main
struct RickMortyAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            CharacterView(viewModel: appDelegate.dependencies.makeCharacterViewModel())
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var dependencies: Dependencies!
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        dependencies = Dependencies()
        return true
    }
}
