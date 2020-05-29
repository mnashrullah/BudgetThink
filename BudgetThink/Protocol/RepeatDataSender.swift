//
//  RepeatDataSender.swift
//  BudgetThink
//
//  Created by Farras Doko on 28/05/20.
//  Copyright © 2020 Muhammad Nashrullah. All rights reserved.
//

import Foundation

protocol RepeatDataSender {
    func onDone(repeatAmount: Int, repeatPeriod: String)
}
