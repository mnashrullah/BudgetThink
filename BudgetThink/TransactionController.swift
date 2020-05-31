//
//  TransactionController.swift
//  BudgetThink
//
//  Created by Naratama on 19/05/20.
//  Copyright © 2020 Muhammad Nashrullah. All rights reserved.
//

import UIKit

class TransactionController: UIViewController {
    
    var transactionItem = Array<Finance>()

    @IBOutlet weak var WhiteView: UIView!
    @IBOutlet weak var tableTransaction: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newLayer = CAGradientLayer()
        newLayer.colors = [UIColor.darkBlueGradient.cgColor, UIColor.lightBlueGradient.cgColor]
        newLayer.frame = view.frame
        newLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        newLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        view.layer.insertSublayer(newLayer, at: 0)
        
        WhiteView.layer.cornerRadius = 45
        
        tableTransaction.delegate = self
        tableTransaction.dataSource = self
        transactionItem = CDManager.shared.loadData()
        tableTransaction.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        transactionItem = CDManager.shared.loadData()
        tableTransaction.reloadData()
    }

}

extension TransactionController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableTransaction.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as! TransactionCell
        let item = transactionItem[indexPath.row]
        
        let type = item.isIncome ? "Income":"Expense"
        var image: UIImage?
        
        switch item.category?.lowercased() {
        case "clothing":
            image = UIImage(named: "CategoryIExpense-Clothing4")
        case "transportation":
            image = UIImage(named: "CategoryIExpense-Transportation2")
        case "food & beverage":
            image = UIImage(named: "CategoryIExpense-Food & Beverage1")
        case "bonus":
            image = UIImage(named: "CategoryIncome-Bonus2")
        case "utilities":
            image = UIImage(named: "CategoryIExpense-Utilities7")
        case "salary":
            image = UIImage(named: "CategoryIncome-Salary1")
        case "education":
            image = UIImage(named: "CategoryIExpense-Education5")
        case "health":
            image = UIImage(named: "CategoryIExpense-Health6")
        case "household":
            image = UIImage(named: "CategoryIExpense-Household9")
        case "hifestyle":
            image = UIImage(named: "CategoryIExpense-Lifestyle3")
        case "other":
            image = UIImage(named: "CategoryIExpense-Other10")
        case "rent & mortgage":
            image = UIImage(named: "CategoryIExpense-Rent & Mortgage8")
        case "gift":
            image = UIImage(named: "CategoryIncome-Gift3")
        case "passive income":
            image = UIImage(named: "CategoryIncome-Passive Income4")
        default:
            image = UIImage(named: "CategoryIncome-Other5")
        }
        
        cell.title.text = item.desc
        cell.subtitle.text = "\(item.category!) | \(type)"
        cell.total.text = "Rp \(String(item.total))"
        cell.img.image = image
        return cell
    }
    
    
}
