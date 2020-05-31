//
//  UpAnimator.swift
//  BudgetThink
//
//  Created by Farras Doko on 30/05/20.
//  Copyright © 2020 Muhammad Nashrullah. All rights reserved.
//

import UIKit

class UpAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 0.3
    var presenting = true
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
//        let toView = transitionContext.view(forKey: .to)!
        let toContainer = transitionContext.viewController(forKey: .to) as! RepeatViewController
        
        containerView.addSubview(toContainer.view)
        toContainer.backdropView.backgroundColor = .clear
        
        var frm: CGRect = toContainer.menuView.frame
        let heig = frm.origin.y
        frm.origin.y = containerView.frame.maxY + 500
        frm.origin.x = frm.origin.x
        frm.size.width = frm.size.width
        frm.size.height = frm.size.height
        toContainer.menuView.frame = frm
        
        UIView.animate(
          withDuration: duration,
          animations: {
            frm.origin.y = heig
            toContainer.menuView.frame = frm
            toContainer.backdropView.backgroundColor = UIColor(white: 0, alpha: 0.5)
          },
          completion: { _ in
            transitionContext.completeTransition(true)
          }
        )
    }
}
