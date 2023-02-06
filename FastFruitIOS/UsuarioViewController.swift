//
//  UsuarioViewController.swift
//  FastFruitIOS
//
//  Created by Kevin Hernández on 06/02/23.
//

import UIKit

class UsuarioViewController: UIViewController {

    @IBOutlet var direcTF: UITextField!
    @IBOutlet var agregarbtn: UIButton!
    @IBOutlet var direcSV: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func agregarBtnPressed(_ sender: Any) {
        let label = UILabel()
            label.text = direcTF.text
            label.backgroundColor = .white
            label.font = UIFont.systemFont(ofSize: 20)
            direcSV.addArrangedSubview(label)
            direcTF.text = ""
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
