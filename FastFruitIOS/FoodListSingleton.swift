//
//  FoodListSingleton.swift
//  FastFruitIOS
//
//  Created by Kevin Hernández on 05/02/23.
//

import Foundation

class FoodListSingleton {
    static let shared = FoodListSingleton()
    private init() {
        foodList.append(Food(foodImage: "tomate.png", price: "20", restaurantName: "Tomate", foodType: "Verduras"))
        foodList.append(Food(foodImage: "calabazas.png", price: "25", restaurantName: "Calabacita", foodType: "Verduras"))
        // ...
    }
    var foodList = [Food]()
}
