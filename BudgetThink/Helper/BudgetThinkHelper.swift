//
//  BudgetThinkHelper.swift
//  BudgetThink
//
//  Created by Farras Doko on 02/06/20.
//  Copyright © 2020 Muhammad Nashrullah. All rights reserved.
//

import UIKit

class BudgetThinkHelper {
    static func getImage(fromCategory category: String) -> UIImage {
        switch category.lowercased() {
        case "clothing":
            return UIImage(named: "CategoryIExpense-Clothing4")!
        case "transportation":
            return UIImage(named: "CategoryIExpense-Transportation2")!
        case "food & beverage":
            return UIImage(named: "CategoryIExpense-Food & Beverage1")!
        case "bonus":
            return UIImage(named: "CategoryIncome-Bonus2")!
        case "utilities":
            return UIImage(named: "CategoryIExpense-Utilities7")!
        case "salary":
            return UIImage(named: "CategoryIncome-Salary1")!
        case "education":
            return UIImage(named: "CategoryIExpense-Education5")!
        case "health":
            return UIImage(named: "CategoryIExpense-Health6")!
        case "household":
            return UIImage(named: "CategoryIExpense-Household9")!
        case "lifestyle":
            return UIImage(named: "CategoryIExpense-Lifestyle3")!
        case "other":
            return UIImage(named: "CategoryIExpense-Other10")!
        case "rent & mortgage":
            return UIImage(named: "CategoryIExpense-Rent & Mortgage8")!
        case "gift":
            return UIImage(named: "CategoryIncome-Gift3")!
        case "passive income":
            return UIImage(named: "CategoryIncome-Passive Income4")!
        default:
            return UIImage(named: "CategoryIncome-Other5")!
        }
    }
    
    static func getBtnImage(fromCategory category: String) -> UIImage {
        switch category {
        case "Salary":
            return UIImage(named: "SalaryCategory")!
        case "Bonus":
            return UIImage(named: "BonusCategory")!
        case "Gift":
            return UIImage(named: "GiftCategory")!
        case "Passive Income":
            return UIImage(named: "PassiveIncomeCategory")!
        case "Other":
            return UIImage(named: "OtherCategory")!
        case "Food & Beverage":
            return UIImage(named: "Food&BeverageCategory")!
        case "Transportation":
            return UIImage(named: "TransportationCategory")!
        case "Lifestyle":
            return UIImage(named: "LifestyleCategory")!
        case "Clothing":
            return UIImage(named: "ClothingCategory")!
        case "Education":
            return UIImage(named: "EducationCategory")!
        case "Health":
            return UIImage(named: "HealthCategory")!
        case "Utilities":
            return UIImage(named: "UtilitiesCategory")!
        case "Rent & Mortgage":
            return UIImage(named: "Rent&MortgageCategory")!
        case "Household":
            return UIImage(named: "HouseholdCategory")!
        default:
            return UIImage(named: "SalaryCategory")!
        }
    }
    
    static func getColor(fromCategory category: String) -> UIColor {
        var hex = ""
        
        switch category.lowercased() {
        case "clothing":
            hex = "C95501"
        case "transportation":
            hex = "3FC5F0"
        case "food & beverage":
            hex = "C70039"
        case "bonus":
            hex = "FFC60B"
        case "utilities":
            hex = "084177"
        case "salary":
            hex = "5B8C5A"
        case "education":
            hex = "95389E"
        case "health":
            hex = "649D66"
        case "household":
            hex = "7D5A5A"
        case "lifestyle":
            hex = "FA744F"
        case "other":
            hex = "323232"
        case "rent & mortgage":
            hex = "900C3F"
        case "gift":
            hex = "FF5733"
        case "passive income":
            hex = "844685"
        default:
            hex = "323232"
        }
        
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func hexColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
