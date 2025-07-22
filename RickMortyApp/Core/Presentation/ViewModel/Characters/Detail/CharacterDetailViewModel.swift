//
//  CharacterDetailViewModel.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 21/7/25.
//

import Foundation

@MainActor
protocol CharacterDetailViewModel: Sendable {
    var episode: [Episode] { get }
    var loadState: LoadState<[Episode]> { get }
    
    func getEpisodeDetails(character: Character) async
}

@Observable
@MainActor
final class CharacterDetailViewModelImpl: CharacterDetailViewModel {
    
    let useCase: CharacterDetailUseCase
    private(set) var episode: [Episode] = []
    private(set) var loadState: LoadState<[Episode]> = .initial
    
    init(useCase: CharacterDetailUseCase) {
        self.useCase = useCase
    }
    
    func getEpisodeDetails(character: Character) async {
        guard episode.isEmpty else { return }
        
        let episodeIDs = character.episodes.compactMap {
            Int(URL(string: $0)?.lastPathComponent ?? "")
        }
        
        do {
            let fetchedEpisodes = try await withThrowingTaskGroup(of: Episode.self) { group in
                var results: [Episode] = []
                for id in episodeIDs {
                    group.addTask {
                        try await self.useCase.getEpisodes(for: id)
                    }
                }
                
                for try await episode in group {
                    results.append(episode)
                }
                
                return results.sorted { $0.id < $1.id }
            }
            
            episode = fetchedEpisodes
            self.loadState = .success(fetchedEpisodes)
            
        } catch {
            self.loadState = .failure(error)
        }
    }
}
