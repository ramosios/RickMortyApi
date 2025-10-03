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
    @Persisted var episode = List<String>()
    @Persisted var url: String = ""
    @Persisted var created: String = ""
    @Persisted var updatedAt: Date = Date()
}

class LocationReferenceEntity: Object {
    @Persisted var name: String = ""
    @Persisted var url: String = ""
}
