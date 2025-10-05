//
//  SettingsView.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 05/10/25.
//
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var realmManager: RealmManager
    var body: some View {
        VStack {
            Text("Settings")
        }
        .padding()
    }
}

#Preview {
    SettingsView()
}

