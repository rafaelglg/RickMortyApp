//
//  RickMortyManager.swift
//  RickMorty
//
//  Created by Rafael Loggiodice on 13/1/23.
//

import Foundation


enum CharacterViewModelState{
    case initial
    case loading
    case loaded (characters: Characters)
    case error(errorMessage:String)
    
}

struct Characters: Codable {
    
    let info: Info
    let results: [Results]
    }

struct Info: Codable {
    let count:Int
    let pages:Int
    let next: String //= "https://rickandmortyapi.com/api/character
    let prev: String?
}

struct Results: Identifiable,Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct Location: Codable {
    let name: String
    let url: String
}
