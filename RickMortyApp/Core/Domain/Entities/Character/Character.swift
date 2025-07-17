//
//  Character.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 17/7/25.
//

struct CharacterContainer: Codable {
    let results: [Character]
}

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    static var mock: Character {
        return .mocks[0]
    }
    
    static var mocks: [Character] {
        [
            Character(
                id: 1,
                name: "Rick Sanchez",
                status: "Alive",
                species: "Human",
                type: "",
                gender: "Male",
                origin: Origin(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/1"),
                location: Location(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3"),
                image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                episode: [
                    "https://rickandmortyapi.com/api/episode/1",
                    "https://rickandmortyapi.com/api/episode/2",
                    "https://rickandmortyapi.com/api/episode/3",
                    "https://rickandmortyapi.com/api/episode/4",
                    "https://rickandmortyapi.com/api/episode/5",
                    "https://rickandmortyapi.com/api/episode/6"
                ],
                url: "https://rickandmortyapi.com/api/character/1",
                created: "2017-11-04T18:48:46.250Z"
            ),
            Character(
                id: 2,
                name: "Morty Smith",
                status: "Alive",
                species: "Human",
                type: "",
                gender: "Male",
                origin: Origin(
                    name: "Earth (C-137)",
                    url: "https://rickandmortyapi.com/api/location/1"
                ),
                location: Location(
                    name: "Citadel of Ricks",
                    url: "https://rickandmortyapi.com/api/location/3"
                ),
                image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
                episode: [
                    "https://rickandmortyapi.com/api/episode/1",
                    "https://rickandmortyapi.com/api/episode/2",
                    "https://rickandmortyapi.com/api/episode/3",
                    "https://rickandmortyapi.com/api/episode/4",
                    "https://rickandmortyapi.com/api/episode/5",
                    "https://rickandmortyapi.com/api/episode/6"
                ],
                url: "https://rickandmortyapi.com/api/character/2",
                created: "2017-11-04T18:50:21.651Z"
            )
        ]
    }
}

struct Origin: Codable {
    let name: String
    let url: String
}

struct Location: Codable {
    let name: String
    let url: String
}
