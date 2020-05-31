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
    var repeatAmount: Int?
    var repeatPeriod: String?
    let transition = UpAnimator()
    let backTransition = DownAnimator()
    
    let datePickerToolbar = UIDatePicker()
    
    
    @IBOutlet weak var PickADateTextField: UITextField!
    @IBOutlet weak var DescriptionTextField: UITextField!
    @IBOutlet weak var TotalValueTextField: UITextField!
    @IBOutlet weak var DatePicker: UIView!
    @IBOutlet weak var ReceiptView: UIView!
    @IBOutlet weak var ReceiptImage: UIImageView!
    @IBOutlet weak var RepeatView: UIView!
    @IBOutlet weak var CategoryView: UIView!
    @IBOutlet weak var ExpenseButton: UIButton!
    @IBOutlet weak var IncomeButton: UIButton!
    @IBOutlet weak var CategoryButton: UIButton!
    @IBOutlet weak var SwitchButton: UISwitch!
    @IBOutlet weak var repeatDesc: UILabel!
    
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
    @IBAction func saveTap(_ sender: UIButton) {
        let total = Int(TotalValueTextField.text!) ?? 0
        let date = datePickerToolbar.date as NSDate
        let desc = DescriptionTextField.text
        let category = "salary" //sementara, karena category belom jadi
        let amount = NSNumber(value: repeatAmount ?? 0)
        var receipt = NSData()
        if let image = ReceiptImage.image {
            receipt = image.jpegData(compressionQuality: 1.0)! as NSData
        } else {
            print("Trying to show an image not backed by CGImage or no image found!")
        }
        
        // if switch off don't save repeatData
        var finance: Financed?
        if SwitchButton.isOn {
            finance = Financed(total: total as NSNumber,isIncome: !isActive ,date: date, desc: desc, category: category, repeatAmount: amount, repeatPeriod: repeatPeriod, img: receipt)
        } else {
            finance = Financed(total: total as NSNumber,isIncome: !isActive ,date: date, desc: desc, category: category, repeatAmount: nil, repeatPeriod: nil, img: receipt)
        }
        
        CDManager.shared.addData(finance: finance!)
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
        
        DatePicker.isUserInteractionEnabled = true
        let datePicker = UITapGestureRecognizer(target: self, action: #selector(showDatePicker))
        DatePicker.addGestureRecognizer(datePicker)
        
        CategoryView.isUserInteractionEnabled = true
        let showCategoryModal = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        CategoryView.addGestureRecognizer(showCategoryModal)
        
        ReceiptView.isUserInteractionEnabled = true
        let imagePicker = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        ReceiptView.addGestureRecognizer(imagePicker)
        
        RepeatView.isUserInteractionEnabled = true
        let showRepeatModal = UITapGestureRecognizer(target: self, action: #selector(repeatTapped))
        RepeatView.addGestureRecognizer(showRepeatModal)
        
        if let period = repeatPeriod {
            let amount = String(repeatAmount!)
            repeatDesc.text = "\(period) @\(amount)"
            repeatDesc.isHidden = false
        } else {
            repeatDesc.isHidden = true
        }
        
        createDatePicker()
        addDoneTotal()
        TotalValueTextField.becomeFirstResponder()
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
    
    func addDoneTotal() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneTapped))
        toolbar.setItems([doneBtn], animated: true)
        
        TotalValueTextField.inputAccessoryView = toolbar
    }
    
    @objc func doneTapped() {
        self.view.endEditing(true)
    }
    
    @objc func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        
        PickADateTextField.inputAccessoryView = toolbar
        PickADateTextField.inputView = datePickerToolbar
        datePickerToolbar.datePickerMode = .date
        
    }
    
    @objc func showDatePicker() {
        PickADateTextField.becomeFirstResponder()
    }
    
    @objc func donePressed(){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        PickADateTextField.text = formatter.string(from: datePickerToolbar.date)
        self.view.endEditing(true)
    }
    
    
    
    @objc func repeatTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let repeatVC = storyboard.instantiateViewController(identifier: "RepeatVC") as RepeatViewController
        repeatVC.dataSender = self
        if let period = repeatPeriod {
            repeatVC.detail = (repeatAmount, period)
        }
        repeatVC.modalPresentationStyle = .custom
        repeatVC.transitioningDelegate = self
        self.present(repeatVC, animated: true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
}

extension InputDataController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, RepeatDataSender, UIViewControllerTransitioningDelegate {
    
    // MARK: - UIViewControllerTransitioningDelegate
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return backTransition
    }
    
    // MARK: - RepeatDataSender
    
    func onDone(repeatAmount: Int, repeatPeriod: String) {
        if repeatAmount > 0 {
            SwitchButton.setOn(true, animated: false)
            self.repeatAmount = repeatAmount
            self.repeatPeriod = repeatPeriod
            
            repeatDesc.text = "\(repeatPeriod) @\(repeatAmount)x"
            repeatDesc.isHidden = false
        }
    }
    
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
    }
    
}
