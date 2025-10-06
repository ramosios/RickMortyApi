//
//  EpisodesView.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 05/10/25.
//
import SwiftUI

struct EpisodesView: View {
    @StateObject private var viewModel: EpisodeViewModel
    @State private var searchText: String = ""

    init(realmManager: RealmManager) {
        _viewModel = StateObject(wrappedValue: EpisodeViewModel(realmManager: realmManager))
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 8) {
                SearchBar(text: $searchText, placeholder: "Search by episode name")
                List(viewModel.filteredEpisodes(searchText: searchText), id: \.id) { episode in
                    NavigationLink(destination: EpisodeDetailView(episode: episode, viewModel: viewModel)) {
                        EpisodeCell(episode: episode)
                    }
                }
                .navigationTitle("Episodes")
            }
        }
    }
}
