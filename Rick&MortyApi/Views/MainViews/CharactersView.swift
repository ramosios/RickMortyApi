//
//  ContentView.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 03/10/25.
//
import SwiftUI

struct CharactersView: View {
    @StateObject private var viewModel: CharacterViewModel
    @State private var searchText: String = ""

    init(realmManager: RealmManager) {
        _viewModel = StateObject(wrappedValue: CharacterViewModel(realmManager: realmManager))
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 8) {
                SearchBar(text: $searchText, placeholder: "Search by name, species, or origin")
                List(viewModel.filteredCharacters(searchText: searchText), id: \.id) { character in
                    NavigationLink(destination: CharacterDetailView(character: character, viewModel: viewModel)) {
                        CharacterCell(character: character)
                    }
                }
                .navigationTitle("Characters")
            }
        }
    }
}
