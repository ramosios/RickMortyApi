//
//  LocationsView.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 05/10/25.

import SwiftUI

struct LocationsView: View {
    @EnvironmentObject var realmManager: RealmManager
    var body: some View {
        VStack {
            Text("Locations")
        }
        .padding()
    }
}

#Preview {
    LocationsView()
}

