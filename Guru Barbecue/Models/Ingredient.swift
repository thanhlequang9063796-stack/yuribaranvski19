//
//  Ingredient.swift
//  Guru Barbecue
//

import Foundation

struct Ingredient: Identifiable, Codable {
    var id = UUID()
    var name: String
    var quantity: Double
    var unit: String
    var category: IngredientCategory
    var icon: String
    
    enum IngredientCategory: String, Codable, CaseIterable {
        case meat = "Meat"
        case spices = "Spices"
        case vegetables = "Vegetables"
        case marinade = "Marinade"
        case other = "Other"
    }
}

extension Ingredient {
    static var sampleData: [Ingredient] = [
        Ingredient(name: "Beef", quantity: 2.5, unit: "kg", category: .meat, icon: "🥩"),
        Ingredient(name: "Chicken", quantity: 1.5, unit: "kg", category: .meat, icon: "🍗"),
        Ingredient(name: "Lamb", quantity: 1.0, unit: "kg", category: .meat, icon: "🥓"),
        Ingredient(name: "Salt", quantity: 500, unit: "g", category: .spices, icon: "🧂"),
        Ingredient(name: "Black Pepper", quantity: 100, unit: "g", category: .spices, icon: "🌶️"),
        Ingredient(name: "Paprika", quantity: 150, unit: "g", category: .spices, icon: "🌶️"),
        Ingredient(name: "Onions", quantity: 5, unit: "pcs", category: .vegetables, icon: "🧅"),
        Ingredient(name: "Garlic", quantity: 3, unit: "pcs", category: .vegetables, icon: "🧄"),
        Ingredient(name: "Lemon Juice", quantity: 200, unit: "ml", category: .marinade, icon: "🍋"),
        Ingredient(name: "Olive Oil", quantity: 300, unit: "ml", category: .marinade, icon: "🫒")
    ]
}


