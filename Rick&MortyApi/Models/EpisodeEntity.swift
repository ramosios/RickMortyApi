//
//  EpisodeEntity.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 03/10/25.
//
import Foundation
import RealmSwift

class EpisodeEntity: Object, Identifiable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String = ""
    @Persisted var airDate: String = ""
    @Persisted var episode: String = ""
    @Persisted var characters = List<Int>()
    @Persisted var url: String = ""
    @Persisted var created: String = ""

    convenience init(from dto: Episode) {
        self.init()
        self.id = dto.id
        self.name = dto.name
        self.airDate = dto.airDate
        self.episode = dto.episode
        self.characters.append(objectsIn: URLExtractor.extractIds(from: dto.characters))
        self.url = dto.url
        self.created = dto.created
    }
}
