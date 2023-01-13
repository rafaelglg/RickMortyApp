//
//  RickMortyProtocol.swift
//  RickMorty
//
//  Created by Rafael Loggiodice on 13/1/23.
//

import Foundation
import Combine

class RickMortyViewModel : ObservableObject{
    
    @Published var charactersState: CharacterViewModelState = CharacterViewModelState.initial
    
    let rickMortyDataServices : RickMortyService = RickMortyDataService()
    var cancellable = Set<AnyCancellable>()
    
    init(){
        getAllCharacters()
    }
    
    func getAllCharacters(){
        
        charactersState = CharacterViewModelState.loading
        
        rickMortyDataServices.getAllCharacters()
            .sink { [weak self]completion in
            
                switch completion{
                    
                case .finished:
                    print ("Finish")
                    
                case .failure(let error):
                    self?.charactersState = CharacterViewModelState.error(errorMessage: "\(error)")
                }
            } receiveValue: { [weak self]Characters in
                self?.charactersState = CharacterViewModelState.loaded(characters: Characters)
            }
            .store(in: &cancellable)
    }
    
}
