//
//  InputDataController.swift
//  BudgetThink
//
//  Created by Naratama on 19/05/20.
//  Copyright © 2020 Muhammad Nashrullah. All rights reserved.
//
import UIKit

class InputDataController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {

    var isActive:Bool = false
    
    @IBOutlet weak var PickADateTextField: UITextField!
    @IBOutlet weak var DescriptionTextField: UITextField!
    @IBOutlet weak var TotalValueTextField: UITextField!
    @IBOutlet weak var DatePicker: UIView!
    
    let datePickerToolbar = UIDatePicker()
    
    
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
        
        PickADateTextField.text = "Pick a Date"
        PickADateTextField.textColor = UIColor.blackText
        
        DescriptionTextField.text = "Description"
        DescriptionTextField.textColor = UIColor.lightGreyDesc
        
        DatePicker.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped(sender:)))
        tap.delegate = self
        DatePicker.addGestureRecognizer(tap)
        
        createDatePicker()
    }

    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        
        PickADateTextField.inputAccessoryView = toolbar
        PickADateTextField.inputView = datePickerToolbar
        datePickerToolbar.datePickerMode = .date
        
    }
    
    @objc func donePressed(){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        PickADateTextField.text = formatter.string(from: datePickerToolbar.date)
        self.view.endEditing(true)
    }
    
    
    @objc func viewTapped(sender: UITapGestureRecognizer){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        
        toolbar.setItems([doneBtn], animated: true)
        
        PickADateTextField.inputAccessoryView = toolbar
        PickADateTextField.inputView = datePickerToolbar
        datePickerToolbar.datePickerMode = .date
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    @IBAction func DescEditBegin(_ sender: UITextField) {
        if DescriptionTextField.textColor == UIColor.lightGreyDesc {
            DescriptionTextField.text = nil
            DescriptionTextField.textColor = UIColor.blackText
        }
    }
    
    @IBAction func DescEditEnd(_ sender: UITextField) {
        if DescriptionTextField.text!.isEmpty {
            DescriptionTextField.text = "Description"
            DescriptionTextField.textColor = UIColor.lightGreyDesc
        }
    }
    
}
