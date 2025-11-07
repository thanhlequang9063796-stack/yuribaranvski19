//
//  Guru_BarbecueApp.swift
//  Guru Barbecue
//
//  Created by Садыг Садыгов on 03.11.2025.
//

import SwiftUI

@main
struct Guru_BarbecueApp: App {
    @StateObject private var settings = AppSettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(settings)
        }
    }
}
