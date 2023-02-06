//
//  Food.swift
//  FastFruitIOS
//
//  Created by Kevin Hernández on 05/02/23.
//

import Foundation

class Food {
    var foodImage: String = ""
    var price: String = ""
    var restaurantName: String = ""
    var liked: Bool = false
    var foodType: String = ""
    var quantity: Int = 0
    var total: Double = 0.0
    
    init(foodImage: String, price: String, restaurantName: String, foodType: String) {
        self.foodImage = foodImage
        self.price = price
        self.restaurantName = restaurantName
        self.foodType = foodType
        if let priceDouble = Double(price) {
            self.total = priceDouble * Double(quantity)
        } else {
            self.total = 20000000.0
            print("Error al convertir el precio a double: \(price)")
        }
    }
    
    func setFoodQuantity(quantity: Int) {
        self.quantity = quantity
        if let priceDouble = Double(price) {
            self.total = priceDouble * Double(quantity)
        } else {
            self.total = 0.0
            print("Error al convertir el precio a double: \(price)")
        }
    }
}
