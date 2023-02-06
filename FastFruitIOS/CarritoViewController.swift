//
//  CarritoViewController.swift
//  FastFruitIOS
//
//  Created by Kevin Hernández on 06/02/23.
//

import UIKit

class CarritoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var comprarbtn: UIButton!
    @IBOutlet var totallabel: UILabel!
    @IBOutlet var carritoTV: UITableView!
    
    var foodList = FoodListSingleton.shared.foodList
    var total = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carritoTV.delegate = self
        carritoTV.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTotal()
        carritoTV.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodList.filter { $0.quantity > 0 }.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartFoodViewCell", for: indexPath) as! CartFoodViewCell
        let food = foodList.filter { $0.quantity > 0 }[indexPath.row]
        cell.setFood(food: food)
        return cell
    }
    
    @IBAction func comprarbtnPressed(_ sender: Any) {
        var totalAmount = 0.0
           for food in FoodListSingleton.shared.foodList {
               if food.quantity > 0 {
                   totalAmount += food.total
               }
           }
           totallabel.text = "$\(totalAmount)"
           let alert = UIAlertController(title: "Compra Exitosa", message: "Se ha comprado por un total de $\(totalAmount)", preferredStyle: .alert)
           let action = UIAlertAction(title: "OK", style: .default, handler: nil)
           alert.addAction(action)
           self.present(alert, animated: true, completion: nil)
           for food in FoodListSingleton.shared.foodList {
               food.setFoodQuantity(quantity: 0)
           }
           carritoTV.reloadData()
    }
    private func updateTotal() {
         total = foodList.reduce(0) { $0 + $1.total }
         totallabel.text = "$\(total)"
     }
}
