//
//  IngredientsViewModel.swift
//  Guru Barbecue
//

import Foundation
import SwiftUI
import Combine

class IngredientsViewModel: ObservableObject {
    @Published var ingredients: [Ingredient] = []
    
    private let saveKey = "SavedIngredients"
    
    init() {
        loadIngredients()
    }
    
    func addIngredient(_ ingredient: Ingredient) {
        ingredients.append(ingredient)
        saveIngredients()
    }
    
    func updateIngredient(_ ingredient: Ingredient) {
        if let index = ingredients.firstIndex(where: { $0.id == ingredient.id }) {
            ingredients[index] = ingredient
            saveIngredients()
        }
    }
    
    func deleteIngredient(at offsets: IndexSet) {
        ingredients.remove(atOffsets: offsets)
        saveIngredients()
    }
    
    func clearAllData() {
        ingredients = []
        saveIngredients()
    }
    
    func getCategoryData() -> [(category: String, total: Double)] {
        var categoryTotals: [Ingredient.IngredientCategory: Double] = [:]
        
        for ingredient in ingredients {
            categoryTotals[ingredient.category, default: 0] += ingredient.quantity
        }
        
        return categoryTotals.map { (category: $0.key.rawValue, total: $0.value) }
            .sorted { $0.category < $1.category }
    }
    
    private func saveIngredients() {
        if let encoded = try? JSONEncoder().encode(ingredients) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    private func loadIngredients() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([Ingredient].self, from: data) {
            ingredients = decoded
        } else {
            // Start with empty data
            ingredients = []
        }
    }
}

