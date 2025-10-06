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

    init(realmManager: RealmManager) {
        self.realmManager = realmManager
        fetchLocations()
    }
    func fetchLocations() {
        let results = realmManager.realm.objects(LocationEntity.self)
        self.locations = Array(results)
    }
    func fetchCharacters(by ids: [Int]) -> [CharacterEntity] {
           let results = realmManager.realm.objects(CharacterEntity.self).filter("id IN %@", ids)
           return Array(results)
    }
    func filteredLocations(searchText: String) -> [LocationEntity] {
        if searchText.isEmpty {
            return locations
        } else {
                return locations.filter { location in
                    location.name.localizedCaseInsensitiveContains(searchText) ||
                    location.type.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}
