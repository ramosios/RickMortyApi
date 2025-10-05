//
//  EpisodesView.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 05/10/25.
//
import SwiftUI

struct EpisodesView: View {
    @EnvironmentObject var realmManager: RealmManager
    var body: some View {
        VStack {
            Text("Episodes")
        }
        .padding()
    }
}

#Preview {
    EpisodesView()
}

