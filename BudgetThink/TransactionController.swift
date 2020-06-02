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
    var total = 0

    @IBOutlet weak var totalLabel: UILabel!
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
        showTotal()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        transactionItem = CDManager.shared.loadData()
        tableTransaction.reloadData()
        showTotal()
    }
    
    func showTotal() {
        total = 0
        for item in transactionItem {
            total += Int(item.total)
        }
        totalLabel.text = "Rp \(total)"
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
        let image: UIImage = BudgetThinkHelper.getImage(fromCategory: item.category ?? "")
        
        cell.title.text = item.desc
        cell.subtitle.text = "\(item.category ?? "") | \(type)"
        cell.total.text = "Rp \(String(item.total))"
        cell.img.image = image
        print(item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete", handler: {
            (_,_,_) in
            let index = indexPath.row
            let item = self.transactionItem[index]
            print(item)
            CDManager.shared.deleteData(desc: item.desc!, date: item.date!)
            self.transactionItem = CDManager.shared.loadData()
            self.tableTransaction.reloadData()
        })
//        done.backgroundColor = UIColor.orange
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
