//
//  ViewController.swift
//  FastFruitIOS
//
//  Created by Kevin Hernández on 02/02/23.
//

import UIKit

class InicioViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    let categories = ["Todos", "Verduras", "Frutas", "Otros", "Likes"]
    var filteredFoodList = [Food]()
    
    @IBOutlet var foodTV: UITableView!
    
    @IBOutlet var catPV: UIPickerView!
    
    @IBOutlet var catLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodTV.dataSource = self
        catPV.dataSource = self
        catPV.delegate = self
        catLabel.text = categories[0]
        filteredFoodList = FoodListSingleton.shared.foodList
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFoodList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodTableViewCell", for: indexPath) as! FoodTableViewCell
        cell.setFood(food: filteredFoodList[indexPath.row])
        return cell
    }

    // MARK: - UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    // MARK: - UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           catLabel.text = categories[row]
           switch row {
           case 0:
               filteredFoodList = FoodListSingleton.shared.foodList
           case 1:
               filteredFoodList = FoodListSingleton.shared.foodList.filter { $0.foodType == "Verduras" }
           case 2:
               filteredFoodList = FoodListSingleton.shared.foodList.filter { $0.foodType == "Frutas" }
           case 3:
               filteredFoodList = FoodListSingleton.shared.foodList.filter { $0.foodType == "Otros" }
           case 4:
               filteredFoodList = FoodListSingleton.shared.foodList.filter { $0.liked }
           default:
               break
           }
           foodTV.reloadData()
       }
   }
