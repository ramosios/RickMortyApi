//
//  CustomTabBarView.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 05/10/25.
//
import SwiftUI

struct CustomTabBarView: View {
    @Binding var selectedTab: Tab

    enum Tab: Int, CaseIterable {
        case characters, locations, episodes, settings

        var iconName: String {
            switch self {
            case .characters: return "person.3.fill"
            case .locations: return "map.fill"
            case .episodes: return "tv.fill"
            case .settings: return "gearshape.fill"
            }
        }

        var title: String {
            switch self {
            case .characters: return "Characters"
            case .locations: return "Locations"
            case .episodes: return "Episodes"
            case .settings: return "Settings"
            }
        }
    }

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.self) { tab in
                Spacer()
                Button(action: {
                    selectedTab = tab
                }, label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.iconName)
                            .font(.system(size: 20))
                            .foregroundColor(selectedTab == tab ? .accentColor : .gray)
                        Text(tab.title)
                            .font(.caption)
                            .foregroundColor(selectedTab == tab ? .accentColor : .gray)
                    }
                })
                Spacer()
            }
        }
        .padding(.vertical, 10)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
        .padding(.horizontal)
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: -2)
        .cornerRadius(16)
        .shadow(radius: 4)
    }
}

