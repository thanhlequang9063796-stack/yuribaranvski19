//
//  MainView.swift
//  Guru Barbecue
//

import SwiftUI
import Charts

struct MainView: View {
    @StateObject private var viewModel = IngredientsViewModel()
    @StateObject private var quotesVM = QuotesViewModel()
    @EnvironmentObject var settings: AppSettings
    @State private var showingAddSheet = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Quote of the day
                    QuoteCard(quote: quotesVM.currentQuote) {
                        quotesVM.getRandomQuote()
                    }
                    .padding(.horizontal)
                    
                    if settings.showChartFirst {
                        ChartSection(viewModel: viewModel)
                        IngredientsSection(viewModel: viewModel)
                    } else {
                        IngredientsSection(viewModel: viewModel)
                        ChartSection(viewModel: viewModel)
                    }
                }
                .padding(.top)
            }
            .navigationTitle("Guru Barbecue")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddSheet = true }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                AddIngredientView(viewModel: viewModel)
            }
        }
    }
}

struct QuoteCard: View {
    let quote: String
    let onRefresh: () -> Void
    
    var body: some View {
        HStack {
            Text(quote)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()
            
            Button(action: onRefresh) {
                Image(systemName: "arrow.clockwise.circle.fill")
                    .foregroundColor(.white.opacity(0.8))
                    .font(.title2)
            }
        }
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                colors: [Color.orange, Color.red],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(15)
        .shadow(color: .orange.opacity(0.3), radius: 10, x: 0, y: 5)
    }
}

struct IngredientsSection: View {
    @ObservedObject var viewModel: IngredientsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Ingredients Stock")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            if viewModel.ingredients.isEmpty {
                VStack(spacing: 10) {
                    Image(systemName: "tray")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                    Text("No ingredients added yet")
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
            } else {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                    ForEach(viewModel.ingredients) { ingredient in
                        IngredientCard(ingredient: ingredient)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct IngredientCard: View {
    let ingredient: Ingredient
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(ingredient.icon)
                    .font(.system(size: 30))
                Spacer()
                Text(ingredient.category.rawValue)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(categoryColor.opacity(0.2))
                    .foregroundColor(categoryColor)
                    .cornerRadius(8)
            }
            
            Text(ingredient.name)
                .font(.headline)
                .lineLimit(1)
            
            Text("\(String(format: "%.1f", ingredient.quantity)) \(ingredient.unit)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            // Stock indicator
            ProgressView(value: stockPercentage)
                .tint(stockColor)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
    
    private var categoryColor: Color {
        switch ingredient.category {
        case .meat: return .red
        case .spices: return .orange
        case .vegetables: return .green
        case .marinade: return .blue
        case .other: return .purple
        }
    }
    
    private var stockPercentage: Double {
        // Simple calculation: assume max stock is double current quantity
        min(ingredient.quantity / (ingredient.quantity * 2), 1.0)
    }
    
    private var stockColor: Color {
        if stockPercentage > 0.5 {
            return .green
        } else if stockPercentage > 0.2 {
            return .orange
        } else {
            return .red
        }
    }
}

struct ChartSection: View {
    @ObservedObject var viewModel: IngredientsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Stock Overview")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            if !viewModel.ingredients.isEmpty {
                let categoryData = viewModel.getCategoryData()
                
                Chart {
                    ForEach(categoryData, id: \.category) { item in
                        BarMark(
                            x: .value("Category", item.category),
                            y: .value("Total", item.total)
                        )
                        .foregroundStyle(by: .value("Category", item.category))
                        .cornerRadius(8)
                    }
                }
                .frame(height: 250)
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(15)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                .padding(.horizontal)
            } else {
                Text("Add ingredients to see chart")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
        }
    }
}

struct AddIngredientView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: IngredientsViewModel
    
    @State private var name = ""
    @State private var quantity = ""
    @State private var unit = "kg"
    @State private var category: Ingredient.IngredientCategory = .meat
    @State private var selectedIcon = "🥩"
    
    let units = ["kg", "g", "pcs", "ml", "l", "tbsp", "tsp"]
    let icons = ["🥩", "🍗", "🥓", "🐟", "🧂", "🌶️", "🧅", "🧄", "🍋", "🫒", "🥬", "🍅", "🥒"]
    
    var body: some View {
        NavigationView {
            Form {
                Section("Details") {
                    TextField("Name", text: $name)
                    
                    HStack {
                        TextField("Quantity", text: $quantity)
                            .keyboardType(.decimalPad)
                        
                        Picker("Unit", selection: $unit) {
                            ForEach(units, id: \.self) { unit in
                                Text(unit).tag(unit)
                            }
                        }
                    }
                    
                    Picker("Category", selection: $category) {
                        ForEach(Ingredient.IngredientCategory.allCases, id: \.self) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                }
                
                Section("Icon") {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(icons, id: \.self) { icon in
                                Text(icon)
                                    .font(.system(size: 40))
                                    .padding()
                                    .background(selectedIcon == icon ? Color.blue.opacity(0.2) : Color.clear)
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        selectedIcon = icon
                                    }
                            }
                        }
                        .padding(.vertical, 5)
                    }
                }
            }
            .navigationTitle("Add Ingredient")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        addIngredient()
                    }
                    .disabled(name.isEmpty || quantity.isEmpty)
                }
            }
        }
    }
    
    private func addIngredient() {
        guard let quantityValue = Double(quantity) else { return }
        
        let ingredient = Ingredient(
            name: name,
            quantity: quantityValue,
            unit: unit,
            category: category,
            icon: selectedIcon
        )
        
        viewModel.addIngredient(ingredient)
        dismiss()
    }
}

#Preview {
    MainView()
        .environmentObject(AppSettings())
}


