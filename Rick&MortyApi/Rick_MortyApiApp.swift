//
//  Rick_MortyApiApp.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 03/10/25.
//

import SwiftUI

@main
struct Rick_MortyApiApp: App {
    @StateObject private var realmManager = RealmManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(realmManager)
        }
    }
}
