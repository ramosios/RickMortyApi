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

    init(repository: Repository) {
        _viewModel = StateObject(wrappedValue: EpisodeViewModel(repository: repository))
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
