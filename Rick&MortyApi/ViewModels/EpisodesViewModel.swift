//
//  EpisodesViewModel.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 05/10/25.
import Foundation
import RealmSwift

class EpisodeViewModel: ObservableObject {
    @Published var episodes: [EpisodeEntity] = []
    private let repository: Repository

    init(repository: Repository) {
        self.repository = repository
        fetchEpisodes()
    }
    func fetchEpisodes() {
        self.episodes = repository.fetchAllEpisodes()
    }
    func fetchCharacters(by ids: [Int]) -> [CharacterEntity] {
        repository.fetchCharacters(by: ids)
    }
    func filteredEpisodes(searchText: String) -> [EpisodeEntity] {
        if searchText.isEmpty {
            return episodes
        } else {
            return episodes.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}
