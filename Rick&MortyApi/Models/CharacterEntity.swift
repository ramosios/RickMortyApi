//
//  CharacterEntity.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 03/10/25.
//
import Foundation
import RealmSwift

class CharacterEntity: Object, Identifiable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String = ""
    @Persisted var status: String = ""
    @Persisted var species: String = ""
    @Persisted var type: String = ""
    @Persisted var gender: String = ""
    @Persisted var origin: LocationReferenceEntity?
    @Persisted var location: LocationReferenceEntity?
    @Persisted var image: String = ""
    @Persisted var episode = List<Int>()
    @Persisted var url: String = ""
    @Persisted var created: String = ""
    @Persisted var updatedAt: Date = Date()

    convenience init(from dto: Character) {
        self.init()
        self.id = dto.id
        self.name = dto.name
        self.status = dto.status
        self.species = dto.species
        self.type = dto.type
        self.gender = dto.gender
        self.origin = LocationReferenceEntity(from: dto.origin)
        self.location = LocationReferenceEntity(from: dto.location)
        self.image = dto.image
        self.episode.append(objectsIn: URLExtractor.extractIds(from: dto.episode))
        self.url = dto.url
        self.created = dto.created
        self.updatedAt = Date()
    }
}

class LocationReferenceEntity: Object {
    @Persisted var name: String = ""
    @Persisted var id: Int = -1

    convenience init(from dto: LocationReference) {
        self.init()
        self.name = dto.name
        self.id = URLExtractor.extractId(from: dto.url) ?? -1
    }
}
