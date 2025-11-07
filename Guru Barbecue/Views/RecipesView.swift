//
//  RecipesView.swift
//  Guru Barbecue
//

import SwiftUI

struct RecipesView: View {
    @State private var selectedMeatType: Recipe.MeatType?
    @State private var searchText = ""
    
    var recipes = Recipe.sampleData
    
    var filteredRecipes: [Recipe] {
        var filtered = recipes
        
        if let meatType = selectedMeatType {
            filtered = filtered.filter { $0.meatType == meatType }
        }
        
        if !searchText.isEmpty {
            filtered = filtered.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
        
        return filtered
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Meat Type Filter
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        FilterChip(
                            title: "All",
                            isSelected: selectedMeatType == nil,
                            action: { selectedMeatType = nil }
                        )
                        
                        ForEach(Recipe.MeatType.allCases, id: \.self) { type in
                            FilterChip(
                                title: type.rawValue,
                                isSelected: selectedMeatType == type,
                                action: { selectedMeatType = type }
                            )
                        }
                    }
                    .padding()
                }
                .background(Color(.systemBackground))
                
                // Recipes List
                if filteredRecipes.isEmpty {
                    VStack(spacing: 15) {
                        Image(systemName: "book.closed")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        Text("No recipes found")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 15) {
                            ForEach(filteredRecipes) { recipe in
                                NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                    RecipeCard(recipe: recipe)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Recipes")
            .searchable(text: $searchText, prompt: "Search recipes...")
        }
    }
}

struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.orange : Color.gray.opacity(0.2))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(20)
        }
    }
}

struct RecipeCard: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(recipe.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(recipe.meatType.rawValue)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            
            Divider()
            
            // Quick Info
            HStack(spacing: 20) {
                Label(recipe.marinadeTime, systemImage: "clock")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Label(recipe.cookingTime, systemImage: "flame")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct RecipeDetailView: View {
    let recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                // Header Card
                VStack(alignment: .leading, spacing: 10) {
                    Text(recipe.meatType.rawValue)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.orange)
                        .cornerRadius(8)
                    
                    Text(recipe.title)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    HStack(spacing: 25) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Marinade Time")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(recipe.marinadeTime)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Cooking Time")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(recipe.cookingTime)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    LinearGradient(
                        colors: [Color.orange.opacity(0.1), Color.red.opacity(0.1)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(15)
                
                // Ingredients
                VStack(alignment: .leading, spacing: 15) {
                    Text("Ingredients")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    ForEach(Array(recipe.ingredients.enumerated()), id: \.offset) { index, ingredient in
                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                            Text(ingredient)
                                .font(.body)
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.systemBackground))
                .cornerRadius(15)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                
                // Instructions
                VStack(alignment: .leading, spacing: 15) {
                    Text("Instructions")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    ForEach(Array(recipe.instructions.enumerated()), id: \.offset) { index, instruction in
                        HStack(alignment: .top, spacing: 15) {
                            ZStack {
                                Circle()
                                    .fill(Color.orange)
                                    .frame(width: 28, height: 28)
                                
                                Text("\(index + 1)")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            
                            Text(instruction)
                                .font(.body)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Spacer()
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.systemBackground))
                .cornerRadius(15)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
            }
            .padding()
        }
        .navigationTitle("Recipe")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    RecipesView()
}


