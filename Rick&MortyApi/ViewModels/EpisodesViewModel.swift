//
//  EpisodesViewModel.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 05/10/25.
import Foundation
import RealmSwift

class EpisodeViewModel: ObservableObject {
    @Published var episodes: [EpisodeEntity] = []
    private let realmManager: RealmManager

    init(realmManager: RealmManager) {
        self.realmManager = realmManager
        fetchEpisodes()
    }
    func fetchEpisodes() {
        let results = realmManager.realm.objects(EpisodeEntity.self)
        self.episodes = Array(results)
    }
    func fetchCharacters(by ids: [Int]) -> [CharacterEntity] {
        let results = realmManager.realm.objects(CharacterEntity.self).filter("id IN %@", ids)
        return Array(results)
    }
}
