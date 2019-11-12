//
//  ShopManager.swift
//  Game
//
//  Created by Daniel Slupskiy on 20.08.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import Foundation
import SwiftSpinner

class ShopManager {
    
    static var ProductIdWithDollars: [String : Int] = [
        
        "com.gameclub.joywar.500coins" : 500,
        "com.gameclub.joywar.1000coins" : 1000,
        "com.gameclub.joywar.1100coins" : 1100,
        "com.gameclub.joywar.1300coins" : 1300,
        "com.gameclub.joywar.1500coins" : 1500,
        "com.gameclub.joywar.1700coins" : 1700,
        "com.gameclub.joywar.2000coins" : 2000,
        "com.gameclub.joywar.2100coins" : 2100,
        "com.gameclub.joywar.2300coins" : 2300,
        "com.gameclub.joywar.2500coins" : 2500,
        "com.gameclub.joywar.2600coins" : 2600,
        "com.gameclub.joywar.2700coins" : 2700,
        "com.gameclub.joywar.2900coins" : 2900,
        "com.gameclub.joywar.3000coins" : 3000,
        "com.gameclub.joywar.3500coins" : 3500,
        "com.gameclub.joywar.4000coins" : 4000,
        "com.gameclub.joywar.4200coins" : 4200,
        "com.gameclub.joywar.4400coins" : 4400,
        "com.gameclub.joywar.4500coins" : 4500,
        "com.gameclub.joywar.4700coins" : 4700,
        "com.gameclub.joywar.5000coins" : 5000,
        "com.gameclub.joywar.8000coins" : 8000,
        "com.gameclub.joywar.10000coins" : 10000,
        "com.gameclub.joywar.12500coins" : 12500,
        "com.gameclub.joywar.15000coins" : 15000,
        "com.gameclub.joywar.30000coins" : 30000,
        "com.gameclub.joywar.100000coins" : 100000,
        
        "com.gameclub.joywar.removeads" : 0
    ]
    
    static let PriceForIdentifiers: [String: String] = [
        "com.gameclub.joywar.500coins" : "$ 0.99",
        "com.gameclub.joywar.1000coins" : "$ 1.99",
        "com.gameclub.joywar.1100coins" : "$ 2.99",
        "com.gameclub.joywar.1300coins" : "$ 2.99",
        "com.gameclub.joywar.1500coins" : "$ 2.99",
        "com.gameclub.joywar.1700coins" : "$ 3.99",
        "com.gameclub.joywar.2000coins" : "$ 4.99",
        "com.gameclub.joywar.2100coins" : "$ 4.99",
        "com.gameclub.joywar.2300coins" : "$ 4.99",
        "com.gameclub.joywar.2500coins" : "$ 4.99",
        "com.gameclub.joywar.2600coins" : "$ 5.99",
        "com.gameclub.joywar.2700coins" : "$ 5.99",
        "com.gameclub.joywar.2900coins" : "$ 5.99",
        "com.gameclub.joywar.3000coins" : "$ 5.99",
        "com.gameclub.joywar.3500coins" : "$ 6.99",
        "com.gameclub.joywar.4000coins" : "$ 8.99",
        "com.gameclub.joywar.4200coins" : "$ 8.99",
        "com.gameclub.joywar.4400coins" : "$ 8.99",
        "com.gameclub.joywar.4500coins" : "$ 9.99",
        "com.gameclub.joywar.4700coins" : "$ 9.99",
        "com.gameclub.joywar.5000coins" : "$ 9.99",
        "com.gameclub.joywar.8000coins" : "$ 14.99",
        "com.gameclub.joywar.10000coins" : "$ 16.99",
        "com.gameclub.joywar.12500coins" : "$ 17.99",
        "com.gameclub.joywar.15000coins" : "$ 19.99",
        "com.gameclub.joywar.30000coins" : "$ 26.99",
        "com.gameclub.joywar.100000coins" : "$ 49.99"
    ]
    
    static func purchaseProduct(withIdentifier identifier: String, withCompletion completion: @escaping (Bool)-> ()) {
        SwiftSpinner.show("Making purchase...")
        //print("identifier: " + identifier)
        StoreKitManager.shared.purchaseProduct(withIdentifier: identifier) { (success) in
            if success {
                let dollarsBought = ProductIdWithDollars[identifier]!
                updateDollarsToGameData(dollarsBought)
            }
            completion(success)
        }
    }
}
