//
//  TransactionCell.swift
//  BudgetThink
//
//  Created by Farras Doko on 30/05/20.
//  Copyright © 2020 Muhammad Nashrullah. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var total: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
