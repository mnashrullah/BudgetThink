//
//  RepeatViewController.swift
//  BudgetThink
//
//  Created by Farras Doko on 26/05/20.
//  Copyright © 2020 Muhammad Nashrullah. All rights reserved.
//

import UIKit

class RepeatViewController: UIViewController {
    
    var dataSender: RepeatDataSender?
    var detail : (amount: Int?, period: String?)
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var backdropView: UIView!
    @IBOutlet weak var periodView: UIView!
    @IBOutlet weak var periodTxt: UILabel!
    @IBOutlet weak var amountTxt: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationStyle = .custom
        transitioningDelegate = self
        view.backgroundColor = .clear
        
        if let amount = detail.amount {
            amountTxt.text = String(amount)
            periodTxt.text = detail.period
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backdropTap(_:)))
        backdropView.addGestureRecognizer(tapGesture)
        
        let periodGesture = UITapGestureRecognizer(target: self, action: #selector(periodClick))
        periodView.addGestureRecognizer(periodGesture)
    }
    
    @objc func periodClick() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        func alertHandler(action: UIAlertAction) {
            self.periodTxt.text = action.title
        }
        
        let daily = UIAlertAction(title: "Daily", style: .default, handler: alertHandler)
        let weekly = UIAlertAction(title: "Weekly", style: .default, handler: alertHandler)
        let monthly = UIAlertAction(title: "Monthly", style: .default, handler: alertHandler)
        let annual = UIAlertAction(title: "Annual", style: .default, handler: alertHandler)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        })
        for action in [daily, weekly, monthly, annual, cancel] {
            alert.addAction(action)
        }
        
        self.present(alert, animated: true)
        
    }
    
    @objc func backdropTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func stepperClick(_ sender: UIStepper) {
        sender.minimumValue = 0
        sender.stepValue = 1
        amountTxt.text = String(sender.value)
    }
    @IBAction func doneClick(_ sender: Any) {
        let amount = Double(amountTxt.text!)
        let amount2 = Int(amount!)
        dataSender?.onDone(repeatAmount: amount2, repeatPeriod: periodTxt.text!)
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension RepeatViewController: UIViewControllerTransitioningDelegate  {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
}
