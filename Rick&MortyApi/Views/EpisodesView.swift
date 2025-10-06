//
//  EpisodesView.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 05/10/25.
//
import SwiftUI

struct EpisodesView: View {
    @StateObject private var viewModel: EpisodeViewModel

    init(realmManager: RealmManager) {
        _viewModel = StateObject(wrappedValue: EpisodeViewModel(realmManager: realmManager))
    }

    var body: some View {
        NavigationView {
            List(viewModel.episodes, id: \.id) { episode in
                EpisodeCell(episode: episode)
            }
            .navigationTitle("Episodes")
        }
    }
}
