//
//  Episode.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 21/7/25.
//

struct Episode: Sendable, Codable, Hashable, Identifiable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, episode, characters, url, created
        case airDate = "air_date"
    }
    
    static var mock: Episode {
        mocks[0]
    }
    
    static var empty: Episode {
        Episode(id: 0, name: "", airDate: "", episode: "", characters: [], url: "", created: "")
    }
    
    static var mocks: [Episode] {
        [
            Episode(
                id: 1,
                name: "Close Rick-counters of the Rick Kind",
                airDate: "December 2, 2013",
                episode: "S01E01",
                characters: [
                    "https://rickandmortyapi.com/api/character/1",
                    "https://rickandmortyapi.com/api/character/2",
                    "https://rickandmortyapi.com/api/character/35",
                    "https://rickandmortyapi.com/api/character/38",
                    "https://rickandmortyapi.com/api/character/62",
                    "https://rickandmortyapi.com/api/character/92",
                    "https://rickandmortyapi.com/api/character/127",
                    "https://rickandmortyapi.com/api/character/144",
                    "https://rickandmortyapi.com/api/character/158",
                    "https://rickandmortyapi.com/api/character/175",
                    "https://rickandmortyapi.com/api/character/179",
                    "https://rickandmortyapi.com/api/character/181",
                    "https://rickandmortyapi.com/api/character/239",
                    "https://rickandmortyapi.com/api/character/249",
                    "https://rickandmortyapi.com/api/character/271",
                    "https://rickandmortyapi.com/api/character/338",
                    "https://rickandmortyapi.com/api/character/394",
                    "https://rickandmortyapi.com/api/character/395",
                    "https://rickandmortyapi.com/api/character/435"
                ],
                url: "https://rickandmortyapi.com/api/episode/1",
                created: "2017-11-10T12:56:33.798Z"
            ),
            Episode(
                id: 2,
                name: "Lawnmower Dog",
                airDate: "December 9, 2013",
                episode: "S01E02",
                characters: [
                    "https://rickandmortyapi.com/api/character/1",
                    "https://rickandmortyapi.com/api/character/2",
                    "https://rickandmortyapi.com/api/character/38",
                    "https://rickandmortyapi.com/api/character/46",
                    "https://rickandmortyapi.com/api/character/63",
                    "https://rickandmortyapi.com/api/character/80",
                    "https://rickandmortyapi.com/api/character/175",
                    "https://rickandmortyapi.com/api/character/221",
                    "https://rickandmortyapi.com/api/character/239",
                    "https://rickandmortyapi.com/api/character/246",
                    "https://rickandmortyapi.com/api/character/304",
                    "https://rickandmortyapi.com/api/character/305",
                    "https://rickandmortyapi.com/api/character/306",
                    "https://rickandmortyapi.com/api/character/329",
                    "https://rickandmortyapi.com/api/character/338",
                    "https://rickandmortyapi.com/api/character/396",
                    "https://rickandmortyapi.com/api/character/397",
                    "https://rickandmortyapi.com/api/character/398",
                    "https://rickandmortyapi.com/api/character/405"
                ],
                url: "https://rickandmortyapi.com/api/episode/2",
                created: "2017-11-10T12:56:33.916Z"
            ),
            Episode(
                id: 3,
                name: "Anatomy Park",
                airDate: "December 16, 2013",
                episode: "S01E03",
                characters: [
                    "https://rickandmortyapi.com/api/character/1",
                    "https://rickandmortyapi.com/api/character/2",
                    "https://rickandmortyapi.com/api/character/12",
                    "https://rickandmortyapi.com/api/character/17",
                    "https://rickandmortyapi.com/api/character/38",
                    "https://rickandmortyapi.com/api/character/45",
                    "https://rickandmortyapi.com/api/character/96",
                    "https://rickandmortyapi.com/api/character/97",
                    "https://rickandmortyapi.com/api/character/98",
                    "https://rickandmortyapi.com/api/character/99",
                    "https://rickandmortyapi.com/api/character/100",
                    "https://rickandmortyapi.com/api/character/101",
                    "https://rickandmortyapi.com/api/character/108",
                    "https://rickandmortyapi.com/api/character/112",
                    "https://rickandmortyapi.com/api/character/114",
                    "https://rickandmortyapi.com/api/character/169",
                    "https://rickandmortyapi.com/api/character/175",
                    "https://rickandmortyapi.com/api/character/186",
                    "https://rickandmortyapi.com/api/character/201",
                    "https://rickandmortyapi.com/api/character/268",
                    "https://rickandmortyapi.com/api/character/300",
                    "https://rickandmortyapi.com/api/character/302",
                    "https://rickandmortyapi.com/api/character/338",
                    "https://rickandmortyapi.com/api/character/356"
                ],
                url: "https://rickandmortyapi.com/api/episode/3",
                created: "2017-11-10T12:56:34.022Z"
            ),
            Episode(
                id: 4,
                name: "M. Night Shaym-Aliens!",
                airDate: "January 13, 2014",
                episode: "S01E04",
                characters: [
                    "https://rickandmortyapi.com/api/character/1",
                    "https://rickandmortyapi.com/api/character/2",
                    "https://rickandmortyapi.com/api/character/38",
                    "https://rickandmortyapi.com/api/character/87",
                    "https://rickandmortyapi.com/api/character/175",
                    "https://rickandmortyapi.com/api/character/179",
                    "https://rickandmortyapi.com/api/character/181",
                    "https://rickandmortyapi.com/api/character/191",
                    "https://rickandmortyapi.com/api/character/239",
                    "https://rickandmortyapi.com/api/character/241",
                    "https://rickandmortyapi.com/api/character/270",
                    "https://rickandmortyapi.com/api/character/337",
                    "https://rickandmortyapi.com/api/character/338"
                ],
                url: "https://rickandmortyapi.com/api/episode/4",
                created: "2017-11-10T12:56:34.129Z"
            ),
            Episode(
                id: 5,
                name: "Meeseeks and Destroy",
                airDate: "January 20, 2014",
                episode: "S01E05",
                characters: [
                    "https://rickandmortyapi.com/api/character/1",
                    "https://rickandmortyapi.com/api/character/2",
                    "https://rickandmortyapi.com/api/character/38",
                    "https://rickandmortyapi.com/api/character/41",
                    "https://rickandmortyapi.com/api/character/89",
                    "https://rickandmortyapi.com/api/character/116",
                    "https://rickandmortyapi.com/api/character/117",
                    "https://rickandmortyapi.com/api/character/120",
                    "https://rickandmortyapi.com/api/character/175",
                    "https://rickandmortyapi.com/api/character/193",
                    "https://rickandmortyapi.com/api/character/238",
                    "https://rickandmortyapi.com/api/character/242",
                    "https://rickandmortyapi.com/api/character/271",
                    "https://rickandmortyapi.com/api/character/303",
                    "https://rickandmortyapi.com/api/character/326",
                    "https://rickandmortyapi.com/api/character/333",
                    "https://rickandmortyapi.com/api/character/338",
                    "https://rickandmortyapi.com/api/character/343",
                    "https://rickandmortyapi.com/api/character/399",
                    "https://rickandmortyapi.com/api/character/400"
                ],
                url: "https://rickandmortyapi.com/api/episode/5",
                created: "2017-11-10T12:56:34.236Z"
            )
        ]
    }
}
