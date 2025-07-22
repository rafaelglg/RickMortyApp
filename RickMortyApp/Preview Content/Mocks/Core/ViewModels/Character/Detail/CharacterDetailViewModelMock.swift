//
//  CharacterDetailViewModelMock.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 21/7/25.
//

import Foundation

@Observable
@MainActor
final class CharacterDetailViewModelMock: CharacterDetailViewModel {
    
    var episode: [Episode]
    var loadState: LoadState<[Episode]>
    
    init(
        episode: [Episode] = Episode.mocks,
        loadState: LoadState<[Episode]> = .initial
    ) {
        self.episode = episode
        self.loadState = loadState
    }
    
    func getEpisodeDetails(character: Character) async { }
}
