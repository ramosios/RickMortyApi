//
//  Repository.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 07/10/25.
//
import Foundation
import RealmSwift

class Repository {
    private let service: RickAndMortyServicing
    private let realmManager: RealmManager

    init(service: RickAndMortyServicing = RickAndMortyService(), realmManager: RealmManager) {
        self.service = service
        self.realmManager = realmManager
    }
    
    func fetchAllCharacters()-> [CharacterEntity] {
        let results = realmManager.realm.objects(CharacterEntity.self)
        return Array(results)
    }
    
    func fetchAllEpisodes()-> [EpisodeEntity] {
        let results = realmManager.realm.objects(EpisodeEntity.self)
        return Array(results)
    }
    
    func fetchAllLocations()-> [LocationEntity] {
        let results = realmManager.realm.objects(LocationEntity.self)
        return Array(results)
    }
    
    func fetchCharacters(by ids: [Int]) -> [CharacterEntity] {
        let results = realmManager.realm.objects(CharacterEntity.self).filter("id IN %@", ids)
        return Array(results)
    }

    func fetchLocation(by id: Int) -> LocationEntity? {
        return realmManager.realm.objects(LocationEntity.self).filter("id == %@", id).first
    }

    func fetchEpisodes(by ids: [Int]) -> [EpisodeEntity] {
        let results = realmManager.realm.objects(EpisodeEntity.self).filter("id IN %@", ids)
        return Array(results)
    }

    func fetchNewCharacter(id: Int) async throws {
        let character = try await service.fetchCharacter(id: id)
        let characterEntity = CharacterEntity(from: character)
        let realm = realmManager.realm
        try realm.write {
            realm.add(characterEntity, update: .modified)
        }
    }

    func fetchNewEpisode(id: Int) async throws {
        let episode = try await service.fetchEpisode(id: id)
        let episodeEntity = EpisodeEntity(from: episode)
        let realm = realmManager.realm
        try realm.write {
            realm.add(episodeEntity, update: .modified)
        }
    }

    func fetchNewLocation(id: Int) async throws {
        let location = try await service.fetchLocation(id: id)
        let locationEntity = LocationEntity(from: location)
        let realm = realmManager.realm
        try realm.write {
            realm.add(locationEntity, update: .modified)
        }
    }
}
