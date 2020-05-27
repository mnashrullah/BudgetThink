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
    @IBOutlet weak var ReceiptView: UIView!
    @IBOutlet weak var ReceiptImage: UIImageView!
    @IBOutlet weak var RepeatView: UIView!
    
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
    @IBAction func backTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
        
//        DescriptionTextField.text = "Description"
//        DescriptionTextField.textColor = UIColor.lightGreyDesc
        
        DatePicker.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped(sender:)))
        tap.delegate = self
        DatePicker.addGestureRecognizer(tap)
        
        createDatePicker()
        
        ReceiptView.isUserInteractionEnabled = true
        let imagePicker = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        ReceiptView.addGestureRecognizer(imagePicker)
        
        RepeatView.isUserInteractionEnabled = true
        let showRepeatModal = UITapGestureRecognizer(target: self, action: #selector(repeatTapped))
        RepeatView.addGestureRecognizer(showRepeatModal)
    }
    
    @objc func pickImage() {
        
        let prompt = UIAlertController(title: "Choose a Photo",
                                       message: "Please choose a photo.",
                                       preferredStyle: .actionSheet)
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        func presentCamera(_ _: UIAlertAction) {
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true)
        }
        
        let cameraAction = UIAlertAction(title: "Camera",
                                         style: .default,
                                         handler: presentCamera)
        
        func presentAlbums(_ _: UIAlertAction) {
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true)
        }
        
        let albumsAction = UIAlertAction(title: "Photo Library",
                                         style: .default,
                                         handler: presentAlbums)
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        
        prompt.addAction(cameraAction)
        prompt.addAction(albumsAction)
        prompt.addAction(cancelAction)
        
        self.present(prompt, animated: true, completion: nil)
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
    
    @objc func repeatTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let repeatVC = storyboard.instantiateViewController(identifier: "RepeatVC") as RepeatViewController
        
        repeatVC.modalPresentationStyle = .custom
        self.present(repeatVC, animated: true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
}

extension InputDataController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss picker, returning to original root viewController.
        dismiss(animated: true, completion: nil)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController,
                                        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        // Extract chosen image.
        let originalImage: UIImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        // Display image on screen.
        show(originalImage)
        dismiss(animated: true, completion: nil)
    }
    
    func show(_ image: UIImage) {
        ReceiptImage.image = nil
        ReceiptImage.image = image
        
        // Transform image to CGImage.
        guard let cgImage = ReceiptImage.image?.cgImage else {
            print("Trying to show an image not backed by CGImage!")
            return
        }
    }
    
}
