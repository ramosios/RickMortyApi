//
//  LocationViewModel.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 05/10/25.
import Foundation
import RealmSwift

class LocationsViewModel: ObservableObject {
    @Published var locations: [LocationEntity] = []
    private let realmManager: RealmManager
    private var notificationToken: NotificationToken?

    init(realmManager: RealmManager) {
        self.realmManager = realmManager
        fetchLocations()
        observeLocationChanges()
    }

    deinit {
        notificationToken?.invalidate()
    }

    func fetchLocations() {
        let results = realmManager.realm.objects(LocationEntity.self)
        self.locations = Array(results)
    }

    private func observeLocationChanges() {
        let results = realmManager.realm.objects(LocationEntity.self)
        notificationToken = results.observe { [weak self] (changes: RealmCollectionChange) in
            guard let self = self else { return }
            switch changes {
            case .initial, .update:
                self.locations = Array(results)
            case .error(let error):
                print("Error observing Realm changes: \(error)")
            }
        }
    }
    
    func fetchCharacters(by ids: [Int]) -> [CharacterEntity] {
           let results = realmManager.realm.objects(CharacterEntity.self).filter("id IN %@", ids)
           return Array(results)
       }
}
