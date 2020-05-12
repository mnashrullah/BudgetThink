//
//  TransactionsViewController.swift
//  BudgetThink
//
//  Created by Farras Doko on 12/05/20.
//  Copyright © 2020 Muhammad Nashrullah. All rights reserved.
//

import UIKit

class TransactionsViewController: UIViewController {
    
    @IBOutlet weak var roundedView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        roundTheView(part: [.topRight, .topLeft], radius: 20, target: roundedView)
    }
    
    func roundTheView(part: UIRectCorner,radius: Int, target: UIView) {
        let path = UIBezierPath(roundedRect:target.bounds,
                                byRoundingCorners:part,
                                cornerRadii: CGSize(width: radius, height:  radius))
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        target.layer.mask = maskLayer
    }
    
}
