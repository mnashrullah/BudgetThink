//
//  StatisticCell.swift
//  BudgetThink
//
//  Created by Farras Doko on 30/05/20.
//  Copyright © 2020 Muhammad Nashrullah. All rights reserved.
//

import UIKit

class StatisticCell: UITableViewCell {

    @IBOutlet weak var percentage: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var percentBkg: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
