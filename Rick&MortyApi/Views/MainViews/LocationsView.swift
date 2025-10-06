//
//  LocationsView.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 05/10/25.

import SwiftUI

struct LocationsView: View {
    @StateObject private var viewModel: LocationsViewModel
    @State private var searchText: String = ""

    init(realmManager: RealmManager) {
        _viewModel = StateObject(wrappedValue: LocationsViewModel(realmManager: realmManager))
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 8) {
                SearchBar(text: $searchText, placeholder: "Search by name or type")
                List(viewModel.filteredLocations(searchText: searchText), id: \.id) { location in
                    NavigationLink(destination: LocationDetailView(location: location, viewModel: viewModel)) {
                        LocationCell(location: location)
                    }
                }
                .navigationTitle("Location")
            }
        }
    }
}
