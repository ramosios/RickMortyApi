//
//  EpisodesDetailView.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 06/10/25.
//
import SwiftUI

struct EpisodeDetailView: View {
    let episode: EpisodeEntity
    @ObservedObject var viewModel: EpisodeViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Episode Card
                VStack(spacing: 12) {
                    Text(episode.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    Text("Air Date: \(episode.airDate)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("Episode: \(episode.episode)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .shadow(radius: 6)

                // Characters Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Characters")
                        .font(.headline)
                        .padding(.bottom, 4)
                    let characters = viewModel.fetchCharacters(by: Array(episode.characters))
                    if characters.isEmpty {
                        ProgressView()
                    } else {
                        ForEach(characters, id: \.id) { character in
                            CharacterCell(character: character)
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                                .padding(.vertical, 2)
                        }
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(16)
                .shadow(radius: 3)
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(episode.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
