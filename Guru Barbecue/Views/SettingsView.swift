//
//  SettingsView.swift
//  Guru Barbecue
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: AppSettings
    @StateObject private var ingredientsVM = IngredientsViewModel()
    @State private var showingClearAlert = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            Form {
                Section("Appearance") {
                    Toggle(isOn: $settings.isDarkMode) {
                        HStack {
                            Image(systemName: settings.isDarkMode ? "moon.fill" : "sun.max.fill")
                                .foregroundColor(settings.isDarkMode ? .purple : .orange)
                            Text("Dark Mode")
                        }
                    }
                }
                
                Section("Layout") {
                    Toggle(isOn: $settings.showChartFirst) {
                        HStack {
                            Image(systemName: "chart.bar.fill")
                                .foregroundColor(.blue)
                            Text("Show Chart First")
                        }
                    }
                    
                    Text("When enabled, the stock overview chart will appear above ingredient cards on the main screen.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Section("Data Management") {
                    Button(role: .destructive, action: {
                        showingClearAlert = true
                    }) {
                        HStack {
                            Image(systemName: "trash.fill")
                            Text("Clear All Data")
                        }
                    }
                    
                    Text("This will permanently delete all your saved ingredients.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Section("About") {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Language")
                        Spacer()
                        Text("English")
                            .foregroundColor(.secondary)
                    }
                }
                
                Section {
                    VStack(alignment: .center, spacing: 10) {
                        Image(systemName: "flame.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.orange)
                        
                        Text("Guru Barbecue")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Your ultimate BBQ companion")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                }
            }
            .navigationTitle("Settings")
            .alert("Clear All Data", isPresented: $showingClearAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Clear", role: .destructive) {
                    ingredientsVM.clearAllData()
                }
            } message: {
                Text("Are you sure you want to delete all ingredients? This action cannot be undone.")
            }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(AppSettings())
}


