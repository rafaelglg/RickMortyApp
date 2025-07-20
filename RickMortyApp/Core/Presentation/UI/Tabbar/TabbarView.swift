//
//  TabbarView.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 18/7/25.
//

import SwiftUI

struct TabbarView: View {
    
    var dependencies: Dependencies
    @Environment(ProductionPersistanceServices.self) var persistance
    
    var body: some View {
        TabView {
            Tab("Characters", systemImage: "person.fill") {
                CharacterView(
                    viewModel: dependencies.makeCharacterViewModel(persistance: persistance), persistance: persistance
                )
            }
            
            Tab("Episodes", systemImage: "tv") {
                Text("Episodes")
            }
            
            Tab("Settings", systemImage: "gearshape") {
                SettingsView(
                    viewModel: dependencies.makeSettingsViewModel(
                        persistance: persistance
                    )
                )
            }
        }
    }
}

#Preview {
    let dependenciesMock = DependenciesMock()
    TabbarView(dependencies: dependenciesMock)
        .environment(
            ProductionPersistanceServices(
                remote: FirebaseRemotePersistance(),
                local: CacheManagerMock()
            )
        )
}
