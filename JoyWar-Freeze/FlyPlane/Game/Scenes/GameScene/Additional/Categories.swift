//
//  Categories.swift
//  Game
//
//  Created by Daniel Slupskiy on 30.03.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import Foundation

enum Categories: UInt32 {
    case plane = 1      // 1 << 0       // (2^ 0) * 1 = 1
    case world = 2      // 1 << 1       // (2^ 1) * 1 = 2
    case hurdle = 4     // 1 << 2       // (2^ 2) * 1 = 4
    case score = 8      // 1 << 3       // (2^ 3) * 1 = 8
    case dollar = 16    // 1 << 4       // (2^ 4) * 1 = 16
    case candyToDollar = 32 // 1 << 5   // (2^ 5) * 1 = 32
    case superPower = 64 // 1 << 6   // (2^ 6) * 1 = 64
    case ammo = 128 // 1 << 7 // (2 ^ 7) * 1 = 128
    case enemyAmmo = 256 // 1 << 8 // (2 ^ 8) * 1 = 256
    case pathFinder = 512
    case nonDestroyableHurdle = 1024
    
}
