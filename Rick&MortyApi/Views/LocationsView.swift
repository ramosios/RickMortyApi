//
//  LocationsView.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 05/10/25.

import SwiftUI

struct LocationsView: View {
    @StateObject private var viewModel: LocationsViewModel

    init(realmManager: RealmManager) {
        _viewModel = StateObject(wrappedValue: LocationsViewModel(realmManager: realmManager))
    }

    var body: some View {
        NavigationView {
            List(viewModel.locations, id: \.id) { location in
                LocationCell(location: location)
            }
            .navigationTitle("Location")
        }
    }
}

