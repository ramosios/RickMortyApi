//
//  RealmManager.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 04/10/25.
//
import Foundation
import RealmSwift
import SwiftUI

class RealmManager: ObservableObject {
    let realm: Realm

    init() {
        let defaultRealmURL = Realm.Configuration.defaultConfiguration.fileURL!
        let destinationURL = defaultRealmURL.deletingLastPathComponent().appendingPathComponent("app.realm")
        if !FileManager.default.fileExists(atPath: destinationURL.path) {
            guard let bundledRealmURL = Bundle.main.url(forResource: "PreloadedData", withExtension: "realm") else {
                fatalError("Error: PreloadedData.realm not found in the app bundle.")
            }

            do {
                try FileManager.default.copyItem(at: bundledRealmURL, to: destinationURL)
            } catch {
                fatalError("Error copying preloaded Realm database: \(error)")
            }
        }
        var config = Realm.Configuration.defaultConfiguration
        config.fileURL = destinationURL
        config.readOnly = false

        do {
            realm = try Realm(configuration: config)
        } catch {
            fatalError("Error initializing Realm with preloaded file: \(error)")
        }
    }
    //init for testing purposes
    init(realm: Realm) {
        self.realm = realm
    }
}
