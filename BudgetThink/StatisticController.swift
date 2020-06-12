//
//  StatisticController.swift
//  BudgetThink
//
//  Created by Farras Doko on 30/05/20.
//  Copyright © 2020 Muhammad Nashrullah. All rights reserved.
//

import UIKit
import PieCharts

class StatisticController: UIViewController {
    
    var statisticItems = Array<Finance>()
    var categories = Array<String>()
    var totalCategory = Dictionary<String,Int>()
    var total = Int()
    
    var totalC = Int()
    var percent = Float()
    var percentage = String()
    let mText = UILabel()

    
    @IBOutlet weak var tableStatistic: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var chartView: PieChart!
    @IBAction func onChangeSegmented(_ sender: UISegmentedControl) {
        refreshData()
    }
    
    func refreshData(){
        if segmentedControl.selectedSegmentIndex == 0 {
            statisticItems = CDManager.shared.loadDataByIncome(isIncome: true)
        } else {
            statisticItems = CDManager.shared.loadDataByIncome(isIncome: false)
        }
        countCategory()
        
        tableStatistic.reloadData()
        prepareChart()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mText.textColor = .black
        mText.frame = CGRect(x:0, y:0, width: 200, height: 100)
        mText.textAlignment = .center
        mText.center = view.center
        mText.text = "No data available"
        mText.frame.origin.y -= 100
        mText.font = .preferredFont(forTextStyle: .body)
        mText.adjustsFontForContentSizeCategory = true
        view.addSubview(mText)
        
        
        tableStatistic.delegate = self
        tableStatistic.dataSource = self
        
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        if segmentedControl.selectedSegmentIndex == 0 {
            statisticItems = CDManager.shared.loadDataByIncome(isIncome: true)
        } else {
            statisticItems = CDManager.shared.loadDataByIncome(isIncome: false)
        }
        countCategory()
        print("tabbar stats")
    }
    override func viewDidAppear(_ animated: Bool) {
        refreshData()
        print("tabbar stats viewDidAppear")
    }
    
    
    func prepareChart(){
        chartView.models.removeAll()
        chartView.clear()

        for category in categories{
            totalC = totalCategory[category]!
            percent = Float(totalC) / Float(total) * 100
            percentage = ""
            
            if Int(totalC) % total != 0 {
                percentage = String(format: "%.1f", percent)
            } else {
                let p = Int(percent)
                percentage = String(p)
            }
            /*used to change round percent value, 123.456789 become 123.4 **/
            let numberOfPlaces = 1.0
            let multiplier = pow(10.0, numberOfPlaces)
            let num = Double(percent)
            let rounded = round(num * multiplier) / multiplier
            
            /*if empty, initiate model first, if there is data, then insert new data. why ? because previously cannot append the data**/
            if(chartView.models.isEmpty == true){
                chartView.models = [
                    PieSliceModel(
                        value: rounded,
                        color: BudgetThinkHelper.getColor(fromCategory: category))
                ]
            }else{
                chartView.insertSlice(index: 0, model: PieSliceModel(
                    value: rounded,
                    color: BudgetThinkHelper.getColor(fromCategory: category)))
            }
            
            
        }
        
        chartView.layers = [PieLineTextLayer()]
        let viewLayer = PieCustomViewsLayer()
        
        let settings = PieCustomViewsLayerSettings()
        settings.viewRadius = 135
        settings.hideOnOverflow = false
        viewLayer.settings = settings
        
        
        viewLayer.viewGenerator = {slice, center in
            let myView = UIView()
            // add images, animations, etc.
            return myView
        }
        /*if no data, remove chartview**/
        if chartView.models.isEmpty {
            setView(view: chartView, hidden: true)
            setView(view: mText, hidden: false)
        }else{
            setView(view: chartView, hidden: false)
            setView(view: mText, hidden: true)
//            noDataLabel.text = "No data available"
            // Do any additional setup after loading the view.
            
            
        }
        
        
    }
    func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.0, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        })
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
        //        print(category)
        //        print(totalC)
        //        print(percentage)
        //        print(BudgetThinkHelper.getColor(fromCategory: category))
        return cell
        
    }
}
