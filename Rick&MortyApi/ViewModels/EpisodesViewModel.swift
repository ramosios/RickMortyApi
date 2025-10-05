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
    private var notificationToken: NotificationToken?

    init(realmManager: RealmManager) {
        self.realmManager = realmManager
        fetchEpisodes()
        observeEpisodeChanges()
    }

    deinit {
        notificationToken?.invalidate()
    }

    func fetchEpisodes() {
        let results = realmManager.realm.objects(EpisodeEntity.self)
        self.episodes = Array(results)
    }

    private func observeEpisodeChanges() {
        let results = realmManager.realm.objects(EpisodeEntity.self)
        notificationToken = results.observe { [weak self] (changes: RealmCollectionChange) in
            guard let self = self else { return }
            switch changes {
            case .initial, .update:
                self.episodes = Array(results)
            case .error(let error):
                print("Error observing Realm changes for episodes: \(error)")
            }
        }
    }
    func fetchCharacters(by ids: [Int]) -> [CharacterEntity] {
        let results = realmManager.realm.objects(CharacterEntity.self).filter("id IN %@", ids)
        return Array(results)
    }
}
