//
//  DependenciesMock.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 19/7/25.
//

@MainActor
final class DependenciesMock: Dependencies {
    
    func makeCharacterViewModel(persistance: PersistanceServices, network: NetworkManager) -> CharacterViewModel {
        CharacterViewModelMock(loadState: .success(Character.mocks))
    }
    
    func makeCharacterDetailViewModel() -> CharacterDetailViewModel {
        CharacterDetailViewModelMock()
    }
    
    func makeSettingsViewModel(persistance: PersistanceServices) -> SettingsViewModel {
        SettingsViewModelMock()
    }
}
