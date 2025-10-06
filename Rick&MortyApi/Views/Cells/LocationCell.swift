//
//  LocationCell.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 06/10/25.
//
// 
import SwiftUI

struct LocationCell: View {
    let location: LocationEntity

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.name)
                .font(.headline)
            Text(location.type)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    let mockLocation = LocationEntity()
    mockLocation.id = 1
    mockLocation.name = "Earth (C-137)"
    mockLocation.type = "Planet"
    return LocationCell(location: mockLocation)
}
