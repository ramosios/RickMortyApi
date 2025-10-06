//
//  SearchBar.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 06/10/25.
//
import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var placeholder: String

    var body: some View {
        TextField(placeholder, text: $text)
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .shadow(color: Color(.systemGray3), radius: 2, x: 0, y: 1)
            .padding(.horizontal)
    }
}
