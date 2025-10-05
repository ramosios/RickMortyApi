//
//  ContentView.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 03/10/25.
//
import SwiftUI

struct CharactersView: View {
    @StateObject private var viewModel: CharacterViewModel

    init(realmManager: RealmManager) {
        _viewModel = StateObject(wrappedValue: CharacterViewModel(realmManager: realmManager))
    }

    var body: some View {
        NavigationView {
            List(viewModel.characters, id: \.id) { character in
                CharacterCell(character: character)
            }
            .navigationTitle("Characters")
        }
    }
}
