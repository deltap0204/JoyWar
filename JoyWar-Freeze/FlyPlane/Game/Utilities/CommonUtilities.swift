//
//  CommonUtilities.swift
//  FlyPlane
//
//  Created by Dexter on 03/05/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import UIKit

func delay(_ delayInSeconds: Double, closure:@escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(delayInSeconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

func showAlert(_ title: String, message: String, buttonTitle: String) -> Void {
    let alert = UIAlertView()
    
    alert.title = title
    alert.message = message
    alert.addButton(withTitle: buttonTitle)
    
    alert.show()
}

func randomBool() -> Bool {
    return arc4random_uniform(2) == 0 ? true: false
}

func updateDollarsToGameData(_ dollars: Int) {
    guard let existingDollars: Int = localData.object(forKey: "Dollars") as? Int else {
        
        localData.set(0, forKey: "Dollars")
        localData.synchronize()
        return
    }
    
    let newDollars = existingDollars + dollars
    
    localData.set(newDollars, forKey: "Dollars")
    localData.synchronize()
}

func insertDollarsToGameData(_ dollars: Int) {
    guard let _: Int = localData.object(forKey: "Dollars") as? Int else {
        
        localData.set(0, forKey: "Dollars")
        localData.synchronize()
        return
    }
    
    let newDollars = dollars
    
    localData.set(newDollars, forKey: "Dollars")
    localData.synchronize()
}

func getDollarsFromGameData() -> Int {
    guard let _ = localData.object(forKey: "Dollars") else {
        
        localData.set(0, forKey: "Dollars")
        localData.synchronize()
        
        return localData.object(forKey: "Dollars") as! Int
    }
    
    return localData.object(forKey: "Dollars") as! Int
}

func updateHighScoreToGameData(_ score: Int) {
    guard let existingHighScore: Int = localData.object(forKey: "HighScore") as? Int else {
        
        localData.set(score, forKey: "HighScore")
        localData.synchronize()
        return
    }
    
    let newHighScore = (score > existingHighScore) ? score : existingHighScore
    GameHighScore = newHighScore
    
    localData.set(newHighScore, forKey: "HighScore")
    localData.synchronize()
}

func getHighScoreFromGameData() -> Int {
    guard let highScore = localData.object(forKey: "HighScore") as? Int else {
        
        localData.set(0, forKey: "HighScore")
        localData.synchronize()
        
        return localData.object(forKey: "HighScore") as! Int
    }
    
    GameHighScore = highScore
    return highScore
}

func initializeScoreToGameData(_ score: Int) {
    guard let _ = localData.object(forKey: "Score") as? Int else {
        
        localData.set(score, forKey: "Score")
        localData.synchronize()
        return
    }
    
    GameScore = score
    
    localData.set(GameScore, forKey: "Score")
    localData.synchronize()
}
