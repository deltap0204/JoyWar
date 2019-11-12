//
//  AdditionalHurdles.swift
//  Game
//
//  Created by Daniel Slupskiy on 30.03.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import Foundation

enum AdditionalHurdlePositions: UInt32 {
    case top
    case middle
    case bottom
    
    static let _count: AdditionalHurdlePositions.RawValue = {
        var maxValue: UInt32 = 1
        while let _ = AdditionalHurdlePositions(rawValue: maxValue) {
            maxValue+=1
        }
        return maxValue
    }()
    
    static func randomPosition() -> AdditionalHurdlePositions {
        let randomPosition = arc4random_uniform(_count)
        return AdditionalHurdlePositions(rawValue: randomPosition)!
    }
}

enum AdditionalHurdles: UInt32 {
    //case bomb
    case iceStick
    case joyStick
    case bubble
    case gift
    case lollipop
    case enemy
    case iceCream
    case stall
    case donuts
    
    static let _count: AdditionalHurdles.RawValue = {
        var maxValue: UInt32 = 1
        while let _ = AdditionalHurdles(rawValue: maxValue) { maxValue+=1 }
        return maxValue
    }()
    
    static func randomAdditionalHurdle() -> AdditionalHurdles {
        let randomAdditionalHurdle = arc4random_uniform(_count)
        return AdditionalHurdles(rawValue: randomAdditionalHurdle)!
    }
    static func randomAdditionalHurdleWithoutDonut() -> AdditionalHurdles {
        let randomAdditionalHurdle = arc4random_uniform(_count-1)
        return AdditionalHurdles(rawValue: randomAdditionalHurdle)!
    }
    
    static let allValues : Set = [iceStick, joyStick, bubble, gift, lollipop, enemy, iceCream, stall, donuts, donuts]
    
    static func randomTypeFromSet(setWithTypes: Set<AdditionalHurdles>) -> AdditionalHurdles{
        let bufArray = Array(setWithTypes)
        let randomAdditionalHurdle = Int(arc4random_uniform(UInt32(setWithTypes.count)))
        return bufArray[randomAdditionalHurdle]
        
    }
}
