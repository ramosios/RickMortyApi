//
//  Service.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 06/10/25.
import Foundation

enum RickAndMortyServiceError: Error, LocalizedError {
    case invalidURL
    case networkError(Error)
    case decodingError(Error)
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .decodingError(let error):
            return "Decoding error: \(error.localizedDescription)"
        case .unknown:
            return "Unknown error occurred."
        }
    }
}

protocol RickAndMortyServicing {
    func fetchCharacter(id: Int) async throws -> Character
    func fetchEpisode(id: Int) async throws -> Episode
    func fetchLocation(id: Int) async throws -> Location
}

struct RickAndMortyService: RickAndMortyServicing {
    private let baseURL = "https://rickandmortyapi.com/api"

    func fetchCharacter(id: Int) async throws -> Character {
        guard let url = URL(string: "\(baseURL)/character/\(id)") else {
            throw RickAndMortyServiceError.invalidURL
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(Character.self, from: data)
        } catch let error as DecodingError {
            throw RickAndMortyServiceError.decodingError(error)
        } catch {
            throw RickAndMortyServiceError.networkError(error)
        }
    }

    func fetchEpisode(id: Int) async throws -> Episode {
        guard let url = URL(string: "\(baseURL)/episode/\(id)") else {
            throw RickAndMortyServiceError.invalidURL
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(Episode.self, from: data)
        } catch let error as DecodingError {
            throw RickAndMortyServiceError.decodingError(error)
        } catch {
            throw RickAndMortyServiceError.networkError(error)
        }
    }

    func fetchLocation(id: Int) async throws -> Location {
        guard let url = URL(string: "\(baseURL)/location/\(id)") else {
            throw RickAndMortyServiceError.invalidURL
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(Location.self, from: data)
        } catch let error as DecodingError {
            throw RickAndMortyServiceError.decodingError(error)
        } catch {
            throw RickAndMortyServiceError.networkError(error)
        }
    }
}
