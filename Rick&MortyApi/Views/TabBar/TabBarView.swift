//
//  TabBarView.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 05/10/25.
//

import SwiftUI

struct TabBarView: View {
    let repository: Repository
    @State private var selectedTab: CustomTabBarView.Tab = .characters
    @EnvironmentObject private var realmManager: RealmManager

    var body: some View {
        TabView(selection: $selectedTab) {
            CharactersView(repository: repository)
                .tag(CustomTabBarView.Tab.characters)
                .tabItem {
                    Label(CustomTabBarView.Tab.characters.title, systemImage: CustomTabBarView.Tab.characters.iconName)
                }

            LocationsView(repository: repository)
                .tag(CustomTabBarView.Tab.locations)
                .tabItem {
                    Label(CustomTabBarView.Tab.locations.title, systemImage: CustomTabBarView.Tab.locations.iconName)
                }
            EpisodesView(repository: repository)
                .tag(CustomTabBarView.Tab.episodes)
                .tabItem {
                    Label(CustomTabBarView.Tab.episodes.title, systemImage: CustomTabBarView.Tab.episodes.iconName)
                }

            SettingsView()
                .tag(CustomTabBarView.Tab.settings)
                .tabItem {
                    Label(CustomTabBarView.Tab.settings.title, systemImage: CustomTabBarView.Tab.settings.iconName)
                }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

