//
//  AppSettings.swift
//  Guru Barbecue
//

import Foundation
import SwiftUI
import Combine

class AppSettings: ObservableObject {
    @Published var isDarkMode: Bool {
        didSet {
            UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
        }
    }
    
    @Published var showChartFirst: Bool {
        didSet {
            UserDefaults.standard.set(showChartFirst, forKey: "showChartFirst")
        }
    }
    
    init() {
        self.isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        self.showChartFirst = UserDefaults.standard.bool(forKey: "showChartFirst")
    }
}

