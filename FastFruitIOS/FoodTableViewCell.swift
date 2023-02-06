//
//  FoodTableViewCell.swift
//  FastFruitIOS
//
//  Created by Kevin Hernández on 05/02/23.
//

import UIKit

class FoodTableViewCell: UITableViewCell {
    
    @IBOutlet var foodImageView: UIImageView!
    @IBOutlet var lessbtn: UIButton!
    @IBOutlet var addbtn: UIButton!
    @IBOutlet var preciolabel: UILabel!
    @IBOutlet var namelabel: UILabel!
    @IBOutlet var likebtn: UIButton!
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
            foodImageView.image = UIImage(named: "\(food.foodImage)")
            preciolabel.text = food.price
            namelabel.text = food.restaurantName
            likebtn.setImage(food.liked ? UIImage(systemName: "hand.thumbsup.fill") : UIImage(systemName: "hand.thumbsup"), for: .normal)
        }


    @IBAction func addBtnPressed(_ sender: Any) {
        food.quantity += 1
        food.total = Double(food.quantity) * Double(food.price)!
        setFood(food: food)

    }
    @IBAction func lessBtnPressed(_ sender: Any) {
        food.quantity = max(food.quantity - 1, 0)
        food.total = Double(food.quantity) * Double(food.price)!
        setFood(food: food)

    }

    @IBAction func likeBtnPressed(_ sender: Any) {
        food.liked = !food.liked
        setFood(food: food)
    }
    
}
