//
//  Int + Extension.swift
//  Game
//
//  Created by Daniel Slupskiy on 13.04.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import Foundation

extension Int
{
    static func random(range: ClosedRange<Int> ) -> Int
    {
        var offset = 0
        
        if range.lowerBound < 0
        {
            offset = abs(range.lowerBound)
        }
        
        let mini = UInt32(range.lowerBound + offset)
        let maxi = UInt32(range.upperBound   + offset)
        
        return Int(mini + arc4random_uniform(maxi - mini)) - offset
    }
}
