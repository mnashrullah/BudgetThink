//
//  StatisticController.swift
//  BudgetThink
//
//  Created by Farras Doko on 30/05/20.
//  Copyright © 2020 Muhammad Nashrullah. All rights reserved.
//

import UIKit

class StatisticController: UIViewController {
    
    var statisticItems = Array<Finance>()
    var categories = Array<String>()
    var totalCategory = Dictionary<String,Int>()
    var total = Int()
    
    @IBOutlet weak var tableStatistic: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func onChangeSegmented(_ sender: UISegmentedControl) {
        if segmentedControl.selectedSegmentIndex == 0 {
            statisticItems = CDManager.shared.loadDataByIncome(isIncome: true)
        } else {
            statisticItems = CDManager.shared.loadDataByIncome(isIncome: false)
        }
        countCategory()
        tableStatistic.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableStatistic.delegate = self
        tableStatistic.dataSource = self

        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        if segmentedControl.selectedSegmentIndex == 0 {
            statisticItems = CDManager.shared.loadDataByIncome(isIncome: true)
        } else {
            statisticItems = CDManager.shared.loadDataByIncome(isIncome: false)
        }
        countCategory()
    }
    
    func countCategory() {
        categories.removeAll()
        totalCategory.removeAll()
        total = 0
        for statItem in statisticItems {
            let category = statItem.category
            let totalc = statItem.total
            if !categories.contains(category!) {
                categories.append(category!)
                totalCategory[category!] = Int(totalc)
            } else {
                totalCategory[category!]! += Int(totalc)
            }
            total += Int(totalc)
        }
    }
    
}

extension StatisticController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableStatistic.dequeueReusableCell(withIdentifier: "statisticCell", for: indexPath) as! StatisticCell
        let i = indexPath.row
        let category = categories[i]
        let totalC = totalCategory[category]!
        
        let percent = Float(totalC) / Float(total) * 100
        var percentage = ""
        
        if Int(totalC) % total != 0 {
            percentage = String(format: "%.1f", percent)
        } else {
            let p = Int(percent)
            percentage = String(p)
        }
        
        cell.category.text = category
        cell.total.text = "Rp \(String(totalC))"
        cell.percentage.text = "\(percentage)%"
        cell.percentBkg.backgroundColor = BudgetThinkHelper.getColor(fromCategory: category)
        
        return cell
    }
}
