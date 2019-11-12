//
//  NSDate + Ext.swift
//  Game
//
//  Created by Daniel Slupskiy on 27.11.2017.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import Foundation

extension Date {
    
    var dayMonthYear: (day: Int, month: Int, year: Int) {
        let components = Calendar.current.dateComponents([.day, .month, .year], from: self)
        return (components.day!, components.month!, components.year!)
    }
}
