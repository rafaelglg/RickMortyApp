//
//  RickMortty.swift
//  RickMorty
//
//  Created by Rafael Loggiodice on 13/1/23.
//

import Foundation
import Combine

class RickMortyDataService: RickMortyService {
    func getAllCharacters() -> AnyPublisher<Characters, Error> {
        URLSession.shared.dataTaskPublisher(for: URL(string: "https://rickandmortyapi.com/api/character")!)
            .map({$0.data})
            .decode(type: Characters.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
}
