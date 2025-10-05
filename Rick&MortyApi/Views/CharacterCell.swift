//
//  CharacterCell.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 05/10/25.
//
import SwiftUI
struct CharacterCell: View {
    let character: CharacterEntity

    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: character.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } placeholder: {
                ProgressView()
                    .frame(width: 100, height: 100)
                    .background(Color.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(character.name)
                    .font(.headline)
                Text(character.species)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    let mockCharacter: CharacterEntity = {
        let character = CharacterEntity()
        character.id = 1
        character.name = "Rick Sanchez"
        character.status = "Alive"
        character.image = "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
        return character
    }()
    
    return CharacterCell(character: mockCharacter)
}
