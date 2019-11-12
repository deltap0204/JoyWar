//
//  PlayersBackpack.swift
//  Game
//
//  Created by Daniel Slupskiy on 01.04.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import Foundation

struct PlayersBackpack {
    
    struct BackpackKeys {
        private init(){}
        
        static let bubbles = "Backpack.bubbles"
        static let rockets = "Backpack.rockets"
        static let pathFinders = "Backpack.pathFinders"
        static let balloons = "Backpack.balloons"
        static let bullets = "Backpack.bullets"
        
    }
    
    
    // MARK: Properties
    
    static var bubblesCount = 0 {
        didSet {
            if bubblesCount > 999 {
                bubblesCount = 999
            }
        }
    }
    
    static var pathFinderCount = 0 {
        didSet {
            if pathFinderCount > 999 {
                pathFinderCount = 999
            }
        }
    }
    
    static var balloonCount = 0{
        didSet {
            if balloonCount > 999 {
                balloonCount = 999
            }
        }
    }
    
    static var bulletsCount = 0 {
        didSet {
            if bulletsCount > 999 {
                bulletsCount = 999
            }
        }
    }
    
    static var rocketsCount:[RocketType:Int] = [.type1 : 50,
                                           .type2 : 50,
                                           .type3 : 50,
                                           .type4 : 50,
                                           .type5 : 50]
    
    
    // MARK: Lifecycle
    
    private init(){}
    
    
    // MARK: Action
    
    static func loadFromStorage() {
        bubblesCount = localData.integer(forKey: BackpackKeys.bubbles)
        pathFinderCount = localData.integer(forKey: BackpackKeys.pathFinders)
        balloonCount = localData.integer(forKey: BackpackKeys.balloons)
        bulletsCount = localData.integer(forKey: BackpackKeys.bullets)
        //print("Bullets Count: \(bulletsCount)")
        for key in rocketsCount.keys {
            rocketsCount[key] = localData.integer(forKey: BackpackKeys.rockets + "." + key.rawValue)
        }
    }
    
    static func saveToStorage(){
        localData.set(bubblesCount, forKey: BackpackKeys.bubbles)
        localData.set(pathFinderCount, forKey: BackpackKeys.pathFinders)
        localData.set(balloonCount, forKey: BackpackKeys.balloons)
        localData.set(bulletsCount, forKey: BackpackKeys.bullets)
        for (key, value) in rocketsCount {
            localData.set(value, forKey: BackpackKeys.rockets + "." + key.rawValue)
        }
    }
    
    static func startupBonus() {
        localData.set(3, forKey: BackpackKeys.bubbles)
        localData.set(3, forKey: BackpackKeys.pathFinders)
        localData.set(3, forKey: BackpackKeys.balloons)
        localData.set(50, forKey: BackpackKeys.bullets)
        
        for (key, value) in rocketsCount {
            localData.set(3, forKey: BackpackKeys.rockets + "." + key.rawValue)
        }
        
        isBonusGivenForOneTime = true
    }
    
}
