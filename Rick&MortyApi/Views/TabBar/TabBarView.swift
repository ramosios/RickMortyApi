//
//  TabBarView.swift
//  Rick&MortyApi
//
//  Created by Jorge Ramos on 05/10/25.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab: CustomTabBarView.Tab = .characters
    @EnvironmentObject private var realmManager: RealmManager

    var body: some View {
        TabView(selection: $selectedTab) {
            CharactersView(realmManager: realmManager)
                .tag(CustomTabBarView.Tab.characters)
                .tabItem {
                    Label(CustomTabBarView.Tab.characters.title, systemImage: CustomTabBarView.Tab.characters.iconName)
                }

            LocationsView(realmManager: realmManager)
                .tag(CustomTabBarView.Tab.locations)
                .tabItem {
                    Label(CustomTabBarView.Tab.locations.title, systemImage: CustomTabBarView.Tab.locations.iconName)
                }
            EpisodesView(realmManager: realmManager)
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

