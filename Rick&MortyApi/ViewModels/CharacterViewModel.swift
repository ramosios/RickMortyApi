//
//  CharacterViewModel.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 05/10/25.
import Foundation
import RealmSwift

class CharacterViewModel: ObservableObject {
    @Published var characters: [CharacterEntity] = []
    private let realmManager: RealmManager
    private var notificationToken: NotificationToken?

    init(realmManager: RealmManager) {
        self.realmManager = realmManager
        fetchCharacters()
        observeCharacterChanges()
    }

    deinit {
        notificationToken?.invalidate()
    }

    func fetchCharacters() {
        let results = realmManager.realm.objects(CharacterEntity.self)
        self.characters = Array(results)
    }

    private func observeCharacterChanges() {
        let results = realmManager.realm.objects(CharacterEntity.self)
        notificationToken = results.observe { [weak self] (changes: RealmCollectionChange) in
            guard let self = self else { return }
            switch changes {
            case .initial, .update:
                self.characters = Array(results)
            case .error(let error):
                print("Error observing Realm changes for characters: \(error)")
            }
        }
    }
    
    func fetchLocation(by id: Int) -> LocationEntity? {
        return realmManager.realm.objects(LocationEntity.self).filter("id == %@", id).first
    }
    
    func fetchEpisodes(by ids: [Int]) -> [EpisodeEntity] {
        let results = realmManager.realm.objects(EpisodeEntity.self).filter("id IN %@", ids)
        return Array(results)
    }
}
