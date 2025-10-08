//
//  MockService.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 08/10/25.
//
import Foundation
@testable import Rick_MortyApi
class MockRickAndMortyService: RickAndMortyServicing {
    var characterToReturn: Character?
    var episodeToReturn: Episode?
    var locationToReturn: Location?
    var errorToThrow: Error?

    func fetchCharacter(id: Int) async throws -> Character {
        if let error = errorToThrow { throw error }
        guard let character = characterToReturn, character.id == id else {
            throw RickAndMortyServiceError.unknown
        }
        return character
    }

    func fetchEpisode(id: Int) async throws -> Episode {
        if let error = errorToThrow { throw error }
        guard let episode = episodeToReturn, episode.id == id else {
            throw RickAndMortyServiceError.unknown
        }
        return episode
    }

    func fetchLocation(id: Int) async throws -> Location {
        if let error = errorToThrow { throw error }
        guard let location = locationToReturn, location.id == id else {
            throw RickAndMortyServiceError.unknown
        }
        return location
    }
}
