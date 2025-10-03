//
//  URLExtractor.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 03/10/25.
//
import Foundation

struct URLExtractor {
    static func extractId(from url: String) -> Int? {
        guard let lastComponent = url.split(separator: "/").last else {
            return nil
        }
        return Int(lastComponent)
    }

    static func extractIds(from urls: [String]) -> [Int] {
        return urls.compactMap { extractId(from: $0) }
    }
}
