//
//  Location.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 03/10/25.
//
import Foundation

struct Location: Codable, Identifiable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}
