//
//  CartFoodViewCell.swift
//  FastFruitIOS
//
//  Created by Kevin Hernández on 05/02/23.
//

import UIKit

class CartFoodViewCell: UITableViewCell {

    @IBOutlet var quantitylabel: UILabel!
    @IBOutlet var preciolabel: UILabel!
    @IBOutlet var addbtn: UIButton!
    @IBOutlet var namelabel: UILabel!
    @IBOutlet var lessbtn: UIButton!
    @IBOutlet var FoodImageView: UIImageView!
    var food: Food!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setFood(food: Food) {
            self.food = food
            FoodImageView.image = UIImage(named: "\(food.foodImage)")
            preciolabel.text = food.price
            namelabel.text = food.restaurantName
        quantitylabel.text = "\(food.quantity)"

        }

    @IBAction func lessbtnpressed(_ sender: Any) {
        food.quantity = max(food.quantity - 1, 0)
        food.total = Double(food.quantity) * Double(food.price)!
        setFood(food: food)
    }
    @IBAction func addbtnpressed(_ sender: Any) {
        food.quantity += 1
        food.total = Double(food.quantity) * Double(food.price)!
        setFood(food: food)
    }
    
   

}
