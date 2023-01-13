//
//  RickMortyProtocol.swift
//  RickMorty
//
//  Created by Rafael Loggiodice on 13/1/23.
//

import Foundation
import Combine

protocol RickMortyService{
    func getAllCharacters () -> AnyPublisher<Characters,Error>
}
