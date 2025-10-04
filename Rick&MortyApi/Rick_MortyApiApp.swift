//
//  Rick_MortyApiApp.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 03/10/25.
//

import SwiftUI

@main
struct Rick_MortyApiApp: App {
    init() {
        do {
            try RealmDatabaseGenerator.generate()
        } catch {
            print("Error generating Realm database: \(error)")
        }
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
