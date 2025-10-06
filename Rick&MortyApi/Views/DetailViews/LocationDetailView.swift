//
//  LocationDetailView.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 06/10/25.
//
import SwiftUI

struct LocationDetailView: View {
    let location: LocationEntity
    @ObservedObject var viewModel: LocationsViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Location Card
                VStack(spacing: 12) {
                    Text(location.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    Text("Type: \(location.type)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("Dimension: \(location.dimension)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .shadow(radius: 6)

                // Residents Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Residents")
                        .font(.headline)
                        .padding(.bottom, 4)
                    let residents = viewModel.fetchCharacters(by: Array(location.residents))
                    if residents.isEmpty {
                        ProgressView()
                    } else {
                        ForEach(residents, id: \.id) { character in
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
        .navigationTitle(location.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
