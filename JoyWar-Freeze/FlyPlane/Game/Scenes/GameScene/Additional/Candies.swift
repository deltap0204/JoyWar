//
//  Candies.swift
//  Game
//
//  Created by Daniel Slupskiy on 30.03.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import Foundation

enum Candies: UInt32 {
    case biscuit
    case chew
    case chocolate
    case dairy
    case gem
    case jelly
    case spiral
    case sugar
    
    static let _count: Candies.RawValue = {
        var maxValue: UInt32 = 1
        while let _ = Candies(rawValue: maxValue) { maxValue+=1 }
        return maxValue
    }()
    
    static func randomCandy() -> Candies {
        // pick and return a new value
        let rand = arc4random_uniform(_count)
        return Candies(rawValue: rand)!
    }
}
