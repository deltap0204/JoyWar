//
//  StoreProducts.swift
//  FlyPlane
//
//  Created by Dexter on 04/06/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import StoreKit

struct Products {
    static let Hundred_Dollars_Consumable: String = "com.Studio2Entertainment.FlyPlane.HundredDollars"
    static let FiveHundred_Dollars_Consumable: String = "com.Studio2Entertainment.FlyPlane.FiHundredDollars"
    static let TwoThousand_Dollars_Consumable: String = "com.Studio2Entertainment.FlyPlane.TwoThousandDollars"
    static let FiveThousand_Dollars_Consumable: String = "com.Studio2Entertainment.FlyPlane.FiveThousandDollars"
    static let FiftyThousand_Dollars_Consumable: String = "com.Studio2Entertainment.FlyPlane.FiftyThousandDollars"
    static let OneLakh_Dollars_Consumable: String = "com.Studio2Entertainment.FlyPlane.OneLakhDollars"
    
    static let availableProducts = [ Hundred_Dollars_Consumable,
                            FiveHundred_Dollars_Consumable,
                            TwoThousand_Dollars_Consumable,
                            FiveThousand_Dollars_Consumable,
                            FiftyThousand_Dollars_Consumable,
                            OneLakh_Dollars_Consumable  ]
}

struct ProductDelivery {
    static func deliverProduct(product: String) -> Int {
        switch product {
        case Products.Hundred_Dollars_Consumable:
            deliverConsumable(Products.Hundred_Dollars_Consumable, units: 100)
            return 100
        case Products.FiveHundred_Dollars_Consumable:
            deliverConsumable(Products.FiveHundred_Dollars_Consumable, units: 500)
            return 500
        case Products.TwoThousand_Dollars_Consumable:
            deliverConsumable(Products.TwoThousand_Dollars_Consumable, units: 2000)
            return 2000
        case Products.FiveThousand_Dollars_Consumable:
            deliverConsumable(Products.FiveThousand_Dollars_Consumable, units: 5000)
            return 5000
        case Products.FiftyThousand_Dollars_Consumable:
            deliverConsumable(Products.FiftyThousand_Dollars_Consumable, units: 50000)
            return 50000
        case Products.OneLakh_Dollars_Consumable:
            deliverConsumable(Products.OneLakh_Dollars_Consumable, units: 100000)
            return 100000
        default:
            return 0
        }
    }
    
    static func deliverNonConsumable(identifier: String) {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: identifier)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    static func deliverConsumable(idetifier: String, units: Int) {
        updateDollarsToGameData(units)
    }
    
    static func isProductAvailable(identifier: String) -> Bool {
        if NSUserDefaults.standardUserDefaults().boolForKey(identifier) == true {
            return true
        } else {
            return false
        }
    }
    
    static func remainingUnits(identifier: String) -> Int {
        return NSUserDefaults.standardUserDefaults().integerForKey(identifier)
    }
}