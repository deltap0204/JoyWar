//
//  GameContent.swift
//  FlyPlane
//
//  Created by Dexter on 04/06/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation

enum ProductType {
    case consumable
    case nonconsumable
}

struct ProductContent {
    var identifier: String
    var purchaseType: ProductType
    var content: String
}

struct GameContent {
    static let main = [
                        ProductContent(identifier: "com.Studio2Entertainment.FlyPlane.HundredDollars", purchaseType: .consumable, content: "100"),
                        ProductContent(identifier: "com.Studio2Entertainment.FlyPlane.FiHundredDollars", purchaseType: .consumable, content: "500"),
                        ProductContent(identifier: "com.Studio2Entertainment.FlyPlane.TwoThousandDollars", purchaseType: .consumable, content: "2000"),
                        ProductContent(identifier: "com.Studio2Entertainment.FlyPlane.FiveThousandDollars", purchaseType: .consumable, content: "5000"),
                        ProductContent(identifier: "com.Studio2Entertainment.FlyPlane.FiftyThousandDollars", purchaseType: .consumable, content: "50000"),
                        ProductContent(identifier: "com.Studio2Entertainment.FlyPlane.OneLakhDollars", purchaseType: .consumable, content: "100000")]
}