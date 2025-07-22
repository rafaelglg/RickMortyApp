//
//  Dependencies.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 18/7/25.
//

@MainActor
protocol Dependencies {
    func makeCharacterViewModel(persistance: PersistanceServices, network: NetworkManager) -> CharacterViewModel
    func makeSettingsViewModel(persistance: PersistanceServices) -> SettingsViewModel
    func makeCharacterDetailViewModel() -> CharacterDetailViewModel
}

@MainActor
final class DependenciesImpl: Dependencies {
    
    let apiService: APIService = APIServiceImpl()
    
    func makeCharacterViewModel(persistance: PersistanceServices, network: NetworkManager) -> CharacterViewModel {
        let service: CharacterService = CharacterServiceImpl(apiService: apiService)
        let repository: CharacterRepository = CharacterRepositoryImpl(
            service: service,
            persistance: persistance
        )
        let useCase: CharacterUseCase = CharacterUseCaseImpl(repository: repository)
        
        return CharacterViewModelImpl(useCase: useCase, network: network)
    }
    
    func makeSettingsViewModel(persistance: PersistanceServices) -> SettingsViewModel {
        SettingsViewModelImpl(localPersistance: persistance)
    }
    
    func makeCharacterDetailViewModel() -> CharacterDetailViewModel {
        let detailService = CharacterDetailServiceImpl(apiService: apiService)
        let detailRepository = CharacterDetailRepositoryImpl(service: detailService)
        let detailUseCase = CharacterDetailUseCaseImpl(repository: detailRepository)
        
        return CharacterDetailViewModelImpl(useCase: detailUseCase)
    }
        
}
