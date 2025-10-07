//
//  Rick_MortyApiApp.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 03/10/25.
//

import SwiftUI

@main
struct Rick_MortyApiApp: App {
    private let repository: Repository

    init() {
        let realmManager = RealmManager()
        self.repository = Repository(realmManager: realmManager)
    }

    var body: some Scene {
        WindowGroup {
            TabBarView(repository: repository)
        }
    }
}
