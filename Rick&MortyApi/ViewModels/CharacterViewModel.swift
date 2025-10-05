//
//  CharacterViewModel.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 05/10/25.
import Foundation
import RealmSwift
import SwiftUICore

class CharacterViewModel: ObservableObject {
    @Published var characters: [CharacterEntity] = []
    @EnvironmentObject private var realmManager: RealmManager

    init() {
        fetchCharacters()
    }

    func fetchCharacters() {
        let results = realmManager.realm.objects(CharacterEntity.self)
        self.characters = Array(results)
    }

    func fetchLocation(by id: Int) -> LocationEntity? {
        return realmManager.realm.objects(LocationEntity.self).filter("id == %@", id).first
    }
        
    func fetchEpisodes(by ids: [Int]) -> [EpisodeEntity] {
        let results = realmManager.realm.objects(EpisodeEntity.self).filter("id IN %@", ids)
            return Array(results)
    }
}
