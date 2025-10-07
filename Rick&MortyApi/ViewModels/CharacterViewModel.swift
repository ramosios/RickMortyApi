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
    private let repository: Repository

    init(repository: Repository) {
        self.repository = repository
        fetchCharacters()
    }
    
    func filteredCharacters(searchText: String) -> [CharacterEntity] {
        if searchText.isEmpty {
            return characters
        } else {
            return characters.filter { character in
                    character.name.localizedCaseInsensitiveContains(searchText) ||
                    character.species.localizedCaseInsensitiveContains(searchText) ||
                    (character.origin?.name.localizedCaseInsensitiveContains(searchText) ?? false)
                }
            }
        }

    func fetchCharacters() {
        characters = repository.fetchAllCharacters()
    }

    func fetchLocation(by id: Int) -> LocationEntity? {
        return repository.fetchLocation(by: id)
    }

    func fetchEpisodes(by ids: [Int]) -> [EpisodeEntity] {
        return repository.fetchEpisodes(by: ids)
    }
}
