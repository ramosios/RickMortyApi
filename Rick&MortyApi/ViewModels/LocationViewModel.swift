//
//  LocationViewModel.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 05/10/25.
import Foundation
import RealmSwift

class LocationsViewModel: ObservableObject {
    @Published var locations: [LocationEntity] = []
    private let repository: Repository

    init(repository: Repository) {
        self.repository = repository
        fetchLocations()
    }
    func fetchLocations() {
        self.locations = repository.fetchAllLocations()
    }
    func fetchCharacters(by ids: [Int]) -> [CharacterEntity] {
         return repository.fetchCharacters(by: ids)
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
