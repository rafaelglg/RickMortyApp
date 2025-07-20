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
            TabbarView(dependencies: appDelegate.dependencies)
                .environment(appDelegate.persistance)
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var dependencies: Dependencies!
    var persistance: ProductionPersistanceServices!
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        dependencies = DependenciesImpl()
        
        let localStorage: FileStorage = FileStorageImpl()
        persistance = ProductionPersistanceServices(
            remote: FirebaseRemotePersistance(),
            local: CacheManager(storage: localStorage)
        )
        
        return true
    }
}
