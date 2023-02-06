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
        foodList.append(Food(foodImage: "lechuga.png", price: "18", restaurantName: "Lechuga", foodType: "Verduras"))
        foodList.append(Food(foodImage: "nopal.png", price: "10", restaurantName: "Nopal", foodType: "Verduras"))
        foodList.append(Food(foodImage: "zanahoria.png", price: "10", restaurantName: "Zanahoria", foodType: "Verduras"))
        foodList.append(Food(foodImage: "esparrago.png", price: "60", restaurantName: "Esparrago", foodType: "Verduras"))
        foodList.append(Food(foodImage: "platano.png", price: "15", restaurantName: "Plátano", foodType: "Frutas"))
        foodList.append(Food(foodImage: "manzana.png", price: "38", restaurantName: "Manzana", foodType: "Frutas"))
        foodList.append(Food(foodImage: "sandia.png", price: "20", restaurantName: "Sandia", foodType: "Frutas"))
        foodList.append(Food(foodImage: "papaya.png", price: "18", restaurantName: "Papaya", foodType: "Frutas"))
        foodList.append(Food(foodImage: "uva.png", price: "90", restaurantName: "Uva", foodType: "Frutas"))
        foodList.append(Food(foodImage: "naranja.png", price: "25", restaurantName: "Naranja", foodType: "Frutas"))
        foodList.append(Food(foodImage: "frijol.png", price: "18", restaurantName: "Frijol", foodType: "Otros"))
        foodList.append(Food(foodImage: "aba.png", price: "60", restaurantName: "Aba", foodType: "Otros"))
        foodList.append(Food(foodImage: "chicharo.png", price: "24", restaurantName: "Chicharo", foodType: "Otros"))
        foodList.append(Food(foodImage: "guajillo.png", price: "100", restaurantName: "ChileGuajillo", foodType: "Otros"))
        foodList.append(Food(foodImage: "morita.png", price: "90", restaurantName: "ChileMorita", foodType: "Otros"))
        foodList.append(Food(foodImage: "ancho.png", price: "150", restaurantName: "ChileAncho", foodType: "Otros"))
    }
    var foodList = [Food]()
}
