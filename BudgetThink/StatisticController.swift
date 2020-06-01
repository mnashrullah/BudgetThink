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
    
    @IBOutlet weak var tableStatistic: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func onChangeSegmented(_ sender: UISegmentedControl) {
        if segmentedControl.selectedSegmentIndex == 0 {
            statisticItems = CDManager.shared.loadDataByIncome(isIncome: true)
        } else {
            statisticItems = CDManager.shared.loadDataByIncome(isIncome: false)
        }
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
    }
    
}

extension StatisticController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        statisticItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableStatistic.dequeueReusableCell(withIdentifier: "statisticCell", for: indexPath) as! StatisticCell
        let item = statisticItems[indexPath.row]
        
        cell.category.text = item.category
        cell.total.text = "Rp \(String(item.total))"
        cell.percentage.text = "35%"
//        cell.percentBkg.backgroundColor = //change color each category
        
        return cell
    }
}
