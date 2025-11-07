//
//  ContentView.swift
//  Guru Barbecue
//
//  Created by Садыг Садыгов on 03.11.2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var settings: AppSettings
    
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            TimerView()
                .tabItem {
                    Label("Timer", systemImage: "timer")
                }
            
            RecipesView()
                .tabItem {
                    Label("Recipes", systemImage: "book.fill")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
        }
        }
        .tint(.orange)
        .preferredColorScheme(settings.isDarkMode ? .dark : .light)
    }
}

#Preview {
    ContentView()
        .environmentObject(AppSettings())
}
