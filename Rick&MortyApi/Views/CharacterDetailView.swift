
import SwiftUI

struct CharacterDetailView: View {
    let character: CharacterEntity
    @ObservedObject var viewModel: CharacterViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Character Card
                VStack(spacing: 16) {
                    if let imageUrl = URL(string: character.image) {
                        AsyncImage(url: imageUrl) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 220)
                                .frame(maxWidth: .infinity)
                                .clipped()
                                .cornerRadius(16)
                        } placeholder: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(height: 220)
                                ProgressView()
                            }
                        }
                    }
                    Text(character.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    HStack(spacing: 12) {
                        Label(character.status, systemImage: "heart.fill")
                            .font(.subheadline)
                            .foregroundColor(.green)
                        Text(character.species)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        if !character.type.isEmpty {
                            Text(character.type)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Text(character.gender)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .shadow(radius: 6)

                // Origin & Location Row
                HStack(spacing: 16) {
                    // Origin Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Origin")
                            .font(.headline)
                            .padding(.bottom, 4)
                        if let originId = character.origin?.id, originId != -1 {
                            if let origin = viewModel.fetchLocation(by: originId) {
                                LocationCell(location: origin)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(12)
                            } else {
                                ProgressView()
                            }
                        } else {
                            Text("Unknown")
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(16)
                    .shadow(radius: 3)

                    // Location Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Location")
                            .font(.headline)
                            .padding(.bottom, 4)
                        if let locationId = character.location?.id, locationId != -1 {
                            if let location = viewModel.fetchLocation(by: locationId) {
                                LocationCell(location: location)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(12)
                            } else {
                                ProgressView()
                            }
                        } else {
                            Text("Unknown")
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(16)
                    .shadow(radius: 3)
                }

                // Episodes Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Episodes")
                        .font(.headline)
                        .padding(.bottom, 4)
                    let episodes = viewModel.fetchEpisodes(by: Array(character.episode))
                    if episodes.isEmpty {
                        ProgressView()
                    } else {
                        ForEach(episodes, id: \.id) { episode in
                            EpisodeCell(episode: episode)
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
        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
