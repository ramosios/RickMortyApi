//
//  EpisodeCell.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 06/10/25.

import SwiftUI

struct EpisodeCell: View {
    let episode: EpisodeEntity

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(episode.name)
                .font(.headline)
            Text(episode.episode)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    let mockEpisode = EpisodeEntity()
    mockEpisode.id = 1
    mockEpisode.name = "Pilot"
    mockEpisode.episode = "S01E01"
    return EpisodeCell(episode: mockEpisode)
}
