//
//  QuotesViewModel.swift
//  Guru Barbecue
//

import Foundation
import Combine

class QuotesViewModel: ObservableObject {
    @Published var currentQuote: String = ""
    
    private let quotes = [
        "Good barbecue is like a beautiful sunset - it's all about perfect timing! 🌅",
        "The secret to great BBQ? Patience, passion, and perfect coals! 🔥",
        "A true grill master knows: low and slow wins the race! 🏆",
        "The best memories are made gathered around the grill! 👨‍👩‍👧‍👦",
        "BBQ is not just cooking, it's an art form! 🎨",
        "Every great meal starts with quality ingredients and a hot grill! ✨",
        "The aroma of grilling meat is nature's dinner bell! 🔔",
        "Real BBQ masters flip with confidence, not nervousness! 💪",
        "Temperature control is the difference between amateur and pro! 🌡️",
        "Marinades transform good meat into unforgettable experiences! 🥘",
        "A well-timed flip can make or break your perfect kebab! ⏰",
        "The char marks on your meat are badges of honor! 🎖️",
        "Great BBQ brings people together like nothing else! 🤝",
        "Let the meat rest - patience yields perfection! 😌",
        "Every skewer tells a story of flavor and dedication! 📖"
    ]
    
    init() {
        getRandomQuote()
    }
    
    func getRandomQuote() {
        currentQuote = quotes.randomElement() ?? quotes[0]
    }
}

