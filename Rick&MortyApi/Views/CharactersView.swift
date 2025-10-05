//
//  ContentView.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 03/10/25.
//

import SwiftUI

struct CharactersView: View {
    @EnvironmentObject var realmManager: RealmManager
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .onAppear(){
            realmManager.printAllLocations()
        }
        .padding()
    }
}

#Preview {
    CharactersView()
}
