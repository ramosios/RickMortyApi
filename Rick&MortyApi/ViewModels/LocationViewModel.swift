//
//  LocationViewModel.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 05/10/25.
import Foundation
import RealmSwift
import SwiftUICore

class LocationsViewModel: ObservableObject {
    @Published var locations: [LocationEntity] = []
    @EnvironmentObject private var realmManager: RealmManager
    private var notificationToken: NotificationToken?

    init() {
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
}
