//
//  ContentView.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 03/10/25.
//
import SwiftUI

struct CharactersView: View {
    @EnvironmentObject private var realmManager: RealmManager
    @StateObject private var viewModel = CharacterViewModel()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}
