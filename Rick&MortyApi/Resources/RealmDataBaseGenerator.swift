//
//  RealmDataBaseGenerator.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 04/10/25.
//
import Foundation
import RealmSwift

enum RealmDatabaseGeneratorError: Error {
    case fileNotFound(String)
    case decodingError(Error)
    case realmError(Error)
}

class RealmDatabaseGenerator {

    static func generate() throws {
        let realm = try Realm()
        
        try realm.write {
            realm.deleteAll()
        }

        try populateCharacters(in: realm)
        try populateEpisodes(in: realm)
        try populateLocations(in: realm)
        if let fileURL = Realm.Configuration.defaultConfiguration.fileURL {
             print("Realm file is located at: \(fileURL.path)")
         }
    }

    private static func populateCharacters(in realm: Realm) throws {
        let characters: [Character] = try loadAndDecode("all_characters")
        let characterEntities = characters.map { CharacterEntity(from: $0) }
        
        try realm.write {
            realm.add(characterEntities, update: .modified)
        }
    }

    private static func populateEpisodes(in realm: Realm) throws {
        let episodes: [Episode] = try loadAndDecode("all_episodes")
        let episodeEntities = episodes.map { EpisodeEntity(from: $0) }

        try realm.write {
            realm.add(episodeEntities, update: .modified)
        }
    }

    private static func populateLocations(in realm: Realm) throws {
        let locations: [Location] = try loadAndDecode("all_locations")
        let locationEntities = locations.map { LocationEntity(from: $0) }

        try realm.write {
            realm.add(locationEntities, update: .modified)
        }
    }

    private static func loadAndDecode<T: Decodable>(_ filename: String) throws -> [T] {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            throw RealmDatabaseGeneratorError.fileNotFound(filename)
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let items = try decoder.decode([T].self, from: data)
            return items
        } catch {
            throw RealmDatabaseGeneratorError.decodingError(error)
        }
    }
}
