//
//  LocationEntity.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 03/10/25.
//
import Foundation
import RealmSwift

class LocationEntity: Object, Identifiable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String = ""
    @Persisted var type: String = ""
    @Persisted var dimension: String = ""
    @Persisted var residents = List<Int>()
    @Persisted var url: String = ""
    @Persisted var created: String = ""
    @Persisted var updatedAt: Date = Date()
}

extension LocationEntity {
    convenience init(from dto: Location) {
        self.init()
        self.id = dto.id
        self.name = dto.name
        self.type = dto.type
        self.dimension = dto.dimension
        self.url = dto.url
        self.created = dto.created
        self.updatedAt = Date()
        self.residents.append(objectsIn: URLExtractor.extractIds(from: dto.residents))
    }
}
