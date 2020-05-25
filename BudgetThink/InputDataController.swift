//
//  InputDataController.swift
//  BudgetThink
//
//  Created by Naratama on 19/05/20.
//  Copyright © 2020 Muhammad Nashrullah. All rights reserved.
//
import UIKit

class InputDataController: UIViewController {

    var isActive:Bool = false
    
    
    @IBOutlet weak var ExpenseButton: UIButton!
    @IBOutlet weak var IncomeButton: UIButton!
    @IBOutlet weak var CategoryButton: UIButton!
    @IBOutlet weak var SwitchButton: UISwitch!
    
    @IBAction func IncomeTap(_ sender: UIButton) {
        if isActive == true{
            isActive = false
            ExpenseButton.setImage(UIImage(named: "Input&Edit-Expenses"), for: .normal)
            IncomeButton.setImage(UIImage(named: "Input&Edit-IncomesActive"), for: .normal)
            CategoryButton.setImage(UIImage(named: "SalaryCategory"), for: .normal)
        } else {
            isActive = false

        }
    }
    @IBAction func ExpenseTap(_ sender: UIButton) {
        if isActive == false {
            isActive = true
            ExpenseButton.setImage(UIImage(named: "Input&Edit-ExpensesActive"), for: .normal)
            IncomeButton.setImage(UIImage(named: "Input&Edit-Incomes"), for: .normal)
            CategoryButton.setImage(UIImage(named: "ClothingCategory"), for: .normal)
        } else {
            isActive = true
        }
            
            
        }
        
    @IBOutlet weak var WhiteView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        SwitchButton.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        let newLayer = CAGradientLayer()
        newLayer.colors = [UIColor.darkBlueGradient.cgColor, UIColor.lightBlueGradient.cgColor]
        newLayer.frame = view.frame
        newLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        newLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        view.layer.insertSublayer(newLayer, at: 0)
        
       WhiteView.layer.cornerRadius = 45
    }


}
