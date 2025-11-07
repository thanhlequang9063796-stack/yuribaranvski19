//
//  Recipe.swift
//  Guru Barbecue
//

import Foundation

struct Recipe: Identifiable, Codable {
    var id = UUID()
    var title: String
    var meatType: MeatType
    var ingredients: [String]
    var instructions: [String]
    var marinadeTime: String
    var cookingTime: String
    
    enum MeatType: String, Codable, CaseIterable {
        case beef = "Beef"
        case chicken = "Chicken"
        case lamb = "Lamb"
        case pork = "Pork"
        case fish = "Fish"
    }
}

extension Recipe {
    static var sampleData: [Recipe] = [
        Recipe(
            title: "Classic Beef Kebab",
            meatType: .beef,
            ingredients: [
                "2 kg beef (sirloin or tenderloin)",
                "3 large onions",
                "3 tbsp olive oil",
                "2 tsp salt",
                "1 tsp black pepper",
                "1 tsp paprika"
            ],
            instructions: [
                "Cut beef into 3-4 cm cubes",
                "Slice onions and mix with meat",
                "Add oil, salt, pepper, and paprika",
                "Marinate for 2-4 hours in refrigerator",
                "Thread meat onto skewers",
                "Grill over medium-high heat, turning every 2-3 minutes",
                "Cook until internal temperature reaches 145°F (medium-rare)"
            ],
            marinadeTime: "2-4 hours",
            cookingTime: "15-20 minutes"
        ),
        Recipe(
            title: "Spicy Beef Shashlik",
            meatType: .beef,
            ingredients: [
                "2 kg beef",
                "4 onions",
                "4 cloves garlic",
                "3 tbsp vinegar",
                "2 tsp chili powder",
                "2 tsp cumin",
                "Salt and pepper to taste"
            ],
            instructions: [
                "Cube the beef",
                "Blend onions and garlic into paste",
                "Mix paste with vinegar and spices",
                "Coat meat thoroughly and marinate overnight",
                "Skewer the meat",
                "Grill over hot coals, rotating frequently",
                "Rest for 5 minutes before serving"
            ],
            marinadeTime: "8-12 hours",
            cookingTime: "18-22 minutes"
        ),
        Recipe(
            title: "Lemon Herb Chicken Kebab",
            meatType: .chicken,
            ingredients: [
                "1.5 kg chicken breast or thighs",
                "Juice of 3 lemons",
                "4 tbsp olive oil",
                "3 cloves garlic, minced",
                "2 tsp dried oregano",
                "1 tsp thyme",
                "Salt and pepper"
            ],
            instructions: [
                "Cut chicken into uniform pieces",
                "Mix lemon juice, oil, garlic, and herbs",
                "Marinate chicken for 1-3 hours",
                "Thread onto skewers",
                "Grill over medium heat",
                "Turn every 3-4 minutes",
                "Cook until internal temp is 165°F"
            ],
            marinadeTime: "1-3 hours",
            cookingTime: "12-15 minutes"
        ),
        Recipe(
            title: "Tandoori-Style Chicken",
            meatType: .chicken,
            ingredients: [
                "1.5 kg chicken pieces",
                "1 cup yogurt",
                "2 tbsp tandoori masala",
                "1 tbsp ginger-garlic paste",
                "Juice of 1 lemon",
                "2 tbsp oil",
                "Salt to taste"
            ],
            instructions: [
                "Make deep cuts in chicken pieces",
                "Mix yogurt with all spices and lemon juice",
                "Coat chicken well and marinate 4-6 hours",
                "Skewer the chicken",
                "Grill over medium-high heat",
                "Baste with oil while cooking",
                "Cook until charred and fully done"
            ],
            marinadeTime: "4-6 hours",
            cookingTime: "20-25 minutes"
        ),
        Recipe(
            title: "Rosemary Lamb Chops",
            meatType: .lamb,
            ingredients: [
                "1 kg lamb chops or cubed lamb",
                "3 tbsp olive oil",
                "2 tbsp fresh rosemary, chopped",
                "4 cloves garlic, minced",
                "2 tsp salt",
                "1 tsp black pepper",
                "Juice of 1 lemon"
            ],
            instructions: [
                "Prepare lamb by trimming excess fat",
                "Mix oil, rosemary, garlic, and lemon juice",
                "Rub mixture onto lamb",
                "Marinate for 2-4 hours",
                "Grill over high heat",
                "Turn every 2-3 minutes for medium-rare",
                "Let rest before serving"
            ],
            marinadeTime: "2-4 hours",
            cookingTime: "10-15 minutes"
        ),
        Recipe(
            title: "Mint Yogurt Lamb Kebab",
            meatType: .lamb,
            ingredients: [
                "1 kg lamb cubes",
                "1 cup yogurt",
                "3 tbsp fresh mint, chopped",
                "2 tsp cumin",
                "1 tsp coriander",
                "Salt and pepper"
            ],
            instructions: [
                "Cube lamb into even pieces",
                "Blend yogurt with mint and spices",
                "Marinate lamb for 3-6 hours",
                "Thread onto skewers",
                "Grill over medium-high heat",
                "Rotate frequently",
                "Cook to desired doneness"
            ],
            marinadeTime: "3-6 hours",
            cookingTime: "12-18 minutes"
        ),
        Recipe(
            title: "Honey Garlic Pork Kebab",
            meatType: .pork,
            ingredients: [
                "1.5 kg pork shoulder",
                "3 tbsp honey",
                "4 cloves garlic, minced",
                "3 tbsp soy sauce",
                "2 tbsp apple cider vinegar",
                "1 tsp smoked paprika",
                "Pepper to taste"
            ],
            instructions: [
                "Cut pork into cubes",
                "Whisk together honey, garlic, soy sauce, and vinegar",
                "Marinate pork for 2-4 hours",
                "Skewer the meat",
                "Grill over medium heat",
                "Brush with marinade while cooking",
                "Cook until internal temp is 145°F"
            ],
            marinadeTime: "2-4 hours",
            cookingTime: "15-20 minutes"
        ),
        Recipe(
            title: "BBQ Pork Ribs",
            meatType: .pork,
            ingredients: [
                "1.5 kg pork ribs",
                "1/2 cup BBQ sauce",
                "2 tbsp brown sugar",
                "1 tbsp smoked paprika",
                "1 tsp garlic powder",
                "Salt and pepper"
            ],
            instructions: [
                "Cut ribs into portions",
                "Mix dry spices and rub on ribs",
                "Let sit for 1 hour",
                "Grill over medium-low heat",
                "Brush with BBQ sauce in last 10 minutes",
                "Turn frequently to prevent burning",
                "Cook until tender"
            ],
            marinadeTime: "1 hour",
            cookingTime: "25-30 minutes"
        ),
        Recipe(
            title: "Grilled Salmon Skewers",
            meatType: .fish,
            ingredients: [
                "1 kg salmon fillet",
                "3 tbsp olive oil",
                "Juice of 2 lemons",
                "2 tsp dill",
                "2 cloves garlic, minced",
                "Salt and pepper"
            ],
            instructions: [
                "Cut salmon into large cubes",
                "Mix oil, lemon, dill, and garlic",
                "Marinate for 30 minutes (no longer)",
                "Thread onto skewers carefully",
                "Grill over medium heat",
                "Turn gently every 2-3 minutes",
                "Cook until fish flakes easily"
            ],
            marinadeTime: "30 minutes",
            cookingTime: "8-10 minutes"
        ),
        Recipe(
            title: "Spicy Shrimp Kebab",
            meatType: .fish,
            ingredients: [
                "1 kg large shrimp, peeled",
                "3 tbsp olive oil",
                "2 tsp chili powder",
                "1 tsp cumin",
                "3 cloves garlic, minced",
                "Juice of 1 lime",
                "Salt to taste"
            ],
            instructions: [
                "Devein and clean shrimp",
                "Mix all marinade ingredients",
                "Marinate shrimp for 20-30 minutes",
                "Thread onto skewers",
                "Grill over high heat",
                "Turn after 2-3 minutes per side",
                "Cook until pink and opaque"
            ],
            marinadeTime: "20-30 minutes",
            cookingTime: "5-7 minutes"
        )
    ]
}


