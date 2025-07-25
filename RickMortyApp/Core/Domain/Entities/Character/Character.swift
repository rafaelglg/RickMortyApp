//
//  Character.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 17/7/25.
//

import Foundation

struct CharacterContainer: Codable {
    let info: Info
    let results: [Character]
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
    
    static var empty: Info {
        Info(count: 0, pages: 0, next: nil, prev: nil)
    }
}

struct Character: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
    let episodes: [String]
    let url: String
    let created: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, status, species, type, gender, origin, location, image, url, created
        case episodes = "episode"
    }
    
    var imageURL: URL {
        guard let url = URL(string: image) else {
            return URL(filePath: "")
        }
        
        return url
    }
    
    var formattedCreatedDate: String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let date = isoFormatter.date(from: created) else { return "" }

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale.current
        
        return formatter.string(from: date)
    }
    
    static var mock: Character {
        .mocks[0]
    }
    
    static var empty: Character {
        Character(id: 0, name: "", status: "", species: "", type: "", gender: "", origin: Origin(name: "", url: ""), location: Location(name: "", url: ""), image: "", episodes: [""], url: "", created: "")
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
                episodes: [
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
                episodes: [
                    "https://rickandmortyapi.com/api/episode/1",
                    "https://rickandmortyapi.com/api/episode/2",
                    "https://rickandmortyapi.com/api/episode/3",
                    "https://rickandmortyapi.com/api/episode/4",
                    "https://rickandmortyapi.com/api/episode/5",
                    "https://rickandmortyapi.com/api/episode/6"
                ],
                url: "https://rickandmortyapi.com/api/character/2",
                created: "2017-11-04T18:50:21.651Z"
            ),
            Character(
                id: 3,
                name: "Hole in the Wall Where the Men Can See it All",
                status: "Alive",
                species: "Human",
                type: "",
                gender: "Female",
                origin: Origin(
                    name: "Earth (Replacement Dimension)",
                    url: "https://rickandmortyapi.com/api/location/20"
                ),
                location: Location(
                    name: "Earth (Replacement Dimension)",
                    url: "https://rickandmortyapi.com/api/location/20"
                ),
                image: "",
                episodes: [
                    "https://rickandmortyapi.com/api/episode/6",
                    "https://rickandmortyapi.com/api/episode/7",
                    "https://rickandmortyapi.com/api/episode/8",
                    "https://rickandmortyapi.com/api/episode/9",
                    "https://rickandmortyapi.com/api/episode/10",
                    "https://rickandmortyapi.com/api/episode/11",
                    "https://rickandmortyapi.com/api/episode/12",
                    "https://rickandmortyapi.com/api/episode/14",
                    "https://rickandmortyapi.com/api/episode/15",
                    "https://rickandmortyapi.com/api/episode/16",
                    "https://rickandmortyapi.com/api/episode/17",
                    "https://rickandmortyapi.com/api/episode/18",
                    "https://rickandmortyapi.com/api/episode/19",
                    "https://rickandmortyapi.com/api/episode/20",
                    "https://rickandmortyapi.com/api/episode/21",
                    "https://rickandmortyapi.com/api/episode/22",
                    "https://rickandmortyapi.com/api/episode/23",
                    "https://rickandmortyapi.com/api/episode/24",
                    "https://rickandmortyapi.com/api/episode/25",
                    "https://rickandmortyapi.com/api/episode/26",
                    "https://rickandmortyapi.com/api/episode/27",
                    "https://rickandmortyapi.com/api/episode/29",
                    "https://rickandmortyapi.com/api/episode/30",
                    "https://rickandmortyapi.com/api/episode/31",
                    "https://rickandmortyapi.com/api/episode/32",
                    "https://rickandmortyapi.com/api/episode/33",
                    "https://rickandmortyapi.com/api/episode/34",
                    "https://rickandmortyapi.com/api/episode/35",
                    "https://rickandmortyapi.com/api/episode/36",
                    "https://rickandmortyapi.com/api/episode/38",
                    "https://rickandmortyapi.com/api/episode/39",
                    "https://rickandmortyapi.com/api/episode/40",
                    "https://rickandmortyapi.com/api/episode/41",
                    "https://rickandmortyapi.com/api/episode/42",
                    "https://rickandmortyapi.com/api/episode/43",
                    "https://rickandmortyapi.com/api/episode/44",
                    "https://rickandmortyapi.com/api/episode/45",
                    "https://rickandmortyapi.com/api/episode/46",
                    "https://rickandmortyapi.com/api/episode/47",
                    "https://rickandmortyapi.com/api/episode/48",
                    "https://rickandmortyapi.com/api/episode/49",
                    "https://rickandmortyapi.com/api/episode/51"
                ],
                url: "https://rickandmortyapi.com/api/character/3",
                created: "2017-11-04T19:09:56.428Z"
            ),
            Character(
                id: 4,
                name: "Beth Smith",
                status: "Alive",
                species: "Human",
                type: "",
                gender: "Female",
                origin: Origin(
                    name: "Earth (Replacement Dimension)",
                    url: "https://rickandmortyapi.com/api/location/20"
                ),
                location: Location(
                    name: "Earth (Replacement Dimension)",
                    url: "https://rickandmortyapi.com/api/location/20"
                ),
                image: "https://rickandmortyapi.com/api/character/avatar/4.jpeg",
                episodes: [
                    "https://rickandmortyapi.com/api/episode/6",
                    "https://rickandmortyapi.com/api/episode/7",
                    "https://rickandmortyapi.com/api/episode/8",
                    "https://rickandmortyapi.com/api/episode/9",
                    "https://rickandmortyapi.com/api/episode/10",
                    "https://rickandmortyapi.com/api/episode/11",
                    "https://rickandmortyapi.com/api/episode/12",
                    "https://rickandmortyapi.com/api/episode/14",
                    "https://rickandmortyapi.com/api/episode/15",
                    "https://rickandmortyapi.com/api/episode/16",
                    "https://rickandmortyapi.com/api/episode/18",
                    "https://rickandmortyapi.com/api/episode/19",
                    "https://rickandmortyapi.com/api/episode/20",
                    "https://rickandmortyapi.com/api/episode/21",
                    "https://rickandmortyapi.com/api/episode/22",
                    "https://rickandmortyapi.com/api/episode/23",
                    "https://rickandmortyapi.com/api/episode/24",
                    "https://rickandmortyapi.com/api/episode/25",
                    "https://rickandmortyapi.com/api/episode/26",
                    "https://rickandmortyapi.com/api/episode/27",
                    "https://rickandmortyapi.com/api/episode/28",
                    "https://rickandmortyapi.com/api/episode/29",
                    "https://rickandmortyapi.com/api/episode/30",
                    "https://rickandmortyapi.com/api/episode/31",
                    "https://rickandmortyapi.com/api/episode/32",
                    "https://rickandmortyapi.com/api/episode/33",
                    "https://rickandmortyapi.com/api/episode/34",
                    "https://rickandmortyapi.com/api/episode/35",
                    "https://rickandmortyapi.com/api/episode/36",
                    "https://rickandmortyapi.com/api/episode/38",
                    "https://rickandmortyapi.com/api/episode/39",
                    "https://rickandmortyapi.com/api/episode/40",
                    "https://rickandmortyapi.com/api/episode/41",
                    "https://rickandmortyapi.com/api/episode/42",
                    "https://rickandmortyapi.com/api/episode/43",
                    "https://rickandmortyapi.com/api/episode/44",
                    "https://rickandmortyapi.com/api/episode/45",
                    "https://rickandmortyapi.com/api/episode/46",
                    "https://rickandmortyapi.com/api/episode/47",
                    "https://rickandmortyapi.com/api/episode/48",
                    "https://rickandmortyapi.com/api/episode/49",
                    "https://rickandmortyapi.com/api/episode/51"
                ],
                url: "https://rickandmortyapi.com/api/character/4",
                created: "2017-11-04T19:22:43.665Z"
            ),
            Character(
                id: 5,
                name: "Jerry Smith",
                status: "Alive",
                species: "Human",
                type: "",
                gender: "Male",
                origin: Origin(
                    name: "Earth (Replacement Dimension)",
                    url: "https://rickandmortyapi.com/api/location/20"
                ),
                location: Location(
                    name: "Earth (Replacement Dimension)",
                    url: "https://rickandmortyapi.com/api/location/20"
                ),
                image: "https://rickandmortyapi.com/api/character/avatar/5.jpeg",
                episodes: [
                    "https://rickandmortyapi.com/api/episode/6",
                    "https://rickandmortyapi.com/api/episode/7",
                    "https://rickandmortyapi.com/api/episode/8",
                    "https://rickandmortyapi.com/api/episode/9",
                    "https://rickandmortyapi.com/api/episode/10",
                    "https://rickandmortyapi.com/api/episode/11",
                    "https://rickandmortyapi.com/api/episode/12",
                    "https://rickandmortyapi.com/api/episode/13",
                    "https://rickandmortyapi.com/api/episode/14",
                    "https://rickandmortyapi.com/api/episode/15",
                    "https://rickandmortyapi.com/api/episode/16",
                    "https://rickandmortyapi.com/api/episode/18",
                    "https://rickandmortyapi.com/api/episode/19",
                    "https://rickandmortyapi.com/api/episode/20",
                    "https://rickandmortyapi.com/api/episode/21",
                    "https://rickandmortyapi.com/api/episode/22",
                    "https://rickandmortyapi.com/api/episode/23",
                    "https://rickandmortyapi.com/api/episode/26",
                    "https://rickandmortyapi.com/api/episode/29",
                    "https://rickandmortyapi.com/api/episode/30",
                    "https://rickandmortyapi.com/api/episode/31",
                    "https://rickandmortyapi.com/api/episode/32",
                    "https://rickandmortyapi.com/api/episode/33",
                    "https://rickandmortyapi.com/api/episode/35",
                    "https://rickandmortyapi.com/api/episode/36",
                    "https://rickandmortyapi.com/api/episode/38",
                    "https://rickandmortyapi.com/api/episode/39",
                    "https://rickandmortyapi.com/api/episode/40",
                    "https://rickandmortyapi.com/api/episode/41",
                    "https://rickandmortyapi.com/api/episode/42",
                    "https://rickandmortyapi.com/api/episode/43",
                    "https://rickandmortyapi.com/api/episode/44",
                    "https://rickandmortyapi.com/api/episode/45",
                    "https://rickandmortyapi.com/api/episode/46",
                    "https://rickandmortyapi.com/api/episode/47",
                    "https://rickandmortyapi.com/api/episode/48",
                    "https://rickandmortyapi.com/api/episode/49",
                    "https://rickandmortyapi.com/api/episode/50",
                    "https://rickandmortyapi.com/api/episode/51"
                ],
                url: "https://rickandmortyapi.com/api/character/5",
                created: "2017-11-04T19:26:56.301Z"
            ),
            Character(
                id: 6,
                name: "Abadango Cluster Princess",
                status: "Alive",
                species: "Alien",
                type: "",
                gender: "Female",
                origin: Origin(
                    name: "Abadango",
                    url: "https://rickandmortyapi.com/api/location/2"
                ),
                location: Location(
                    name: "Abadango",
                    url: "https://rickandmortyapi.com/api/location/2"
                ),
                image: "https://rickandmortyapi.com/api/character/avatar/6.jpeg",
                episodes: [
                    "https://rickandmortyapi.com/api/episode/27"
                ],
                url: "https://rickandmortyapi.com/api/character/6",
                created: "2017-11-04T19:50:28.250Z"
            ),
            Character(
                id: 7,
                name: "Abradolf Lincler",
                status: "unknown",
                species: "Human",
                type: "Genetic experiment",
                gender: "Male",
                origin: Origin(
                    name: "Earth (Replacement Dimension)",
                    url: "https://rickandmortyapi.com/api/location/20"
                ),
                location: Location(
                    name: "Testicle Monster Dimension",
                    url: "https://rickandmortyapi.com/api/location/21"
                ),
                image: "https://rickandmortyapi.com/api/character/avatar/7.jpeg",
                episodes: [
                    "https://rickandmortyapi.com/api/episode/10",
                    "https://rickandmortyapi.com/api/episode/11"
                ],
                url: "https://rickandmortyapi.com/api/character/7",
                created: "2017-11-04T19:59:20.523Z"
            ),
            Character(
                id: 8,
                name: "Adjudicator Rick",
                status: "Dead",
                species: "Human",
                type: "",
                gender: "Male",
                origin: Origin(
                    name: "unknown",
                    url: ""
                ),
                location: Location(
                    name: "Citadel of Ricks",
                    url: "https://rickandmortyapi.com/api/location/3"
                ),
                image: "https://rickandmortyapi.com/api/character/avatar/8.jpeg",
                episodes: [
                    "https://rickandmortyapi.com/api/episode/28"
                ],
                url: "https://rickandmortyapi.com/api/character/8",
                created: "2017-11-04T20:03:34.737Z"
            ),
            Character(
                id: 9,
                name: "Agency Director",
                status: "Dead",
                species: "Human",
                type: "",
                gender: "Male",
                origin: Origin(
                    name: "Earth (Replacement Dimension)",
                    url: "https://rickandmortyapi.com/api/location/20"
                ),
                location: Location(
                    name: "Earth (Replacement Dimension)",
                    url: "https://rickandmortyapi.com/api/location/20"
                ),
                image: "https://rickandmortyapi.com/api/character/avatar/9.jpeg",
                episodes: [
                    "https://rickandmortyapi.com/api/episode/24"
                ],
                url: "https://rickandmortyapi.com/api/character/9",
                created: "2017-11-04T20:06:54.976Z"
            ),
            Character(
                id: 10,
                name: "Alan Rails",
                status: "Dead",
                species: "Human",
                type: "Superhuman (Ghost trains summoner)",
                gender: "Male",
                origin: Origin(
                    name: "unknown",
                    url: ""
                ),
                location: Location(
                    name: "Worldender's lair",
                    url: "https://rickandmortyapi.com/api/location/4"
                ),
                image: "https://rickandmortyapi.com/api/character/avatar/10.jpeg",
                episodes: [
                    "https://rickandmortyapi.com/api/episode/25"
                ],
                url: "https://rickandmortyapi.com/api/character/10",
                created: "2017-11-04T20:19:09.017Z"
            ),
            Character(
                id: 11,
                name: "Albert Einstein",
                status: "Dead",
                species: "Human",
                type: "",
                gender: "Male",
                origin: Origin(
                    name: "Earth (C-137)",
                    url: "https://rickandmortyapi.com/api/location/1"
                ),
                location: Location(
                    name: "Earth (Replacement Dimension)",
                    url: "https://rickandmortyapi.com/api/location/20"
                ),
                image: "https://rickandmortyapi.com/api/character/avatar/11.jpeg",
                episodes: [
                    "https://rickandmortyapi.com/api/episode/12"
                ],
                url: "https://rickandmortyapi.com/api/character/11",
                created: "2017-11-04T20:20:20.965Z"
            ),
            Character(
                id: 12,
                name: "Alexander",
                status: "Dead",
                species: "Human",
                type: "",
                gender: "Male",
                origin: Origin(
                    name: "Earth (C-137)",
                    url: "https://rickandmortyapi.com/api/location/1"
                ),
                location: Location(
                    name: "Anatomy Park",
                    url: "https://rickandmortyapi.com/api/location/5"
                ),
                image: "https://rickandmortyapi.com/api/character/avatar/12.jpeg",
                episodes: [
                    "https://rickandmortyapi.com/api/episode/3"
                ],
                url: "https://rickandmortyapi.com/api/character/12",
                created: "2017-11-04T20:32:33.144Z"
            ),
            Character(
                id: 13,
                name: "Alien Googah",
                status: "unknown",
                species: "Alien",
                type: "",
                gender: "unknown",
                origin: Origin(
                    name: "unknown",
                    url: ""
                ),
                location: Location(
                    name: "Earth (Replacement Dimension)",
                    url: "https://rickandmortyapi.com/api/location/20"
                ),
                image: "https://rickandmortyapi.com/api/character/avatar/13.jpeg",
                episodes: [
                    "https://rickandmortyapi.com/api/episode/31"
                ],
                url: "https://rickandmortyapi.com/api/character/13",
                created: "2017-11-04T20:33:30.779Z"
            ),
            Character(
                id: 14,
                name: "Alien Morty",
                status: "unknown",
                species: "Alien",
                type: "",
                gender: "Male",
                origin: Origin(
                    name: "unknown",
                    url: ""
                ),
                location: Location(
                    name: "Citadel of Ricks",
                    url: "https://rickandmortyapi.com/api/location/3"
                ),
                image: "https://rickandmortyapi.com/api/character/avatar/14.jpeg",
                episodes: [
                    "https://rickandmortyapi.com/api/episode/10"
                ],
                url: "https://rickandmortyapi.com/api/character/14",
                created: "2017-11-04T20:51:31.373Z"
            ),
            Character(
                id: 21,
                name: "Aqua Morty",
                status: "unknown",
                species: "Humanoid",
                type: "Fish-Person",
                gender: "Male",
                origin: Origin(
                    name: "unknown",
                    url: ""
                ),
                location: Location(
                    name: "Citadel of Ricks",
                    url: "https://rickandmortyapi.com/api/location/3"
                ),
                image: "",
                episodes: [
                    "https://rickandmortyapi.com/api/episode/10",
                    "https://rickandmortyapi.com/api/episode/22"
                ],
                url: "https://rickandmortyapi.com/api/character/21",
                created: "2017-11-04T22:39:48.055Z"
            ),
        ]
    }
}

struct Origin: Codable, Hashable {
    let name: String
    let url: String
}

struct Location: Codable, Hashable {
    let name: String
    let url: String
}
