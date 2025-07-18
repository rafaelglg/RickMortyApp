//
//  Dependencies.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 18/7/25.
//

@MainActor
final class Dependencies {
    
    func makeCharacterViewModel() -> CharacterViewModel {
        let apiService: APIService = APIServiceImpl()
        let service: CharacterService = CharacterServiceImpl(apiService: apiService)
        let repository: CharacterRepository = CharacterRepositoryImpl(service: service)
        let useCase: CharacterUseCase = CharacterUseCaseImpl(repository: repository)
        
        return CharacterViewModelImpl(useCase: useCase)
    }
}
