//
//  Dependencies.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 18/7/25.
//

@MainActor
protocol Dependencies {
    func makeCharacterViewModel(persistance: PersistanceServices) -> CharacterViewModel
    func makeSettingsViewModel(persistance: PersistanceServices) -> SettingsViewModel
}

@MainActor
final class DependenciesImpl: Dependencies {
    
    func makeCharacterViewModel(persistance: PersistanceServices) -> CharacterViewModel {
        let apiService: APIService = APIServiceImpl()
        let service: CharacterService = CharacterServiceImpl(apiService: apiService)
        let repository: CharacterRepository = CharacterRepositoryImpl(
            service: service,
            persistance: persistance
        )
        let useCase: CharacterUseCase = CharacterUseCaseImpl(repository: repository)
        
        return CharacterViewModelImpl(useCase: useCase)
    }
    
    func makeSettingsViewModel(persistance: PersistanceServices) -> SettingsViewModel {
        SettingsViewModelImpl(localPersistance: persistance)
    }
}
