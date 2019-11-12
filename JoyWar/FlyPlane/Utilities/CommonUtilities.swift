//
//  CommonUtilities.swift
//  FlyPlane
//
//  Created by Dexter on 03/05/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import UIKit

func delay(delayInSeconds: Double, closure:() -> ()) {
    dispatch_after(dispatch_time(
        DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
}

func showAlert(title: String, message: String, buttonTitle: String) -> Void {
    let alert = UIAlertView()
    
    alert.title = title
    alert.message = message
    alert.addButtonWithTitle(buttonTitle)
    
    alert.show()
}

func randomBool() -> Bool {
    return arc4random_uniform(2) == 0 ? true: false
}

func updateDollarsToGameData(dollars: Int) {
    guard let existingDollars: Int = localData.objectForKey("Dollars") as? Int else {
        
        localData.setInteger(0, forKey: "Dollars")
        localData.synchronize()
        return
    }
    
    let newDollars = existingDollars + dollars
    
    localData.setInteger(newDollars, forKey: "Dollars")
    localData.synchronize()
}

func insertDollarsToGameData(dollars: Int) {
    guard let _: Int = localData.objectForKey("Dollars") as? Int else {
        
        localData.setInteger(0, forKey: "Dollars")
        localData.synchronize()
        return
    }
    
    let newDollars = dollars
    
    localData.setInteger(newDollars, forKey: "Dollars")
    localData.synchronize()
}

func getDollarsFromGameData() -> Int {
    guard let _ = localData.objectForKey("Dollars") else {
        
        localData.setInteger(0, forKey: "Dollars")
        localData.synchronize()
        
        return localData.objectForKey("Dollars") as! Int
    }
    
    return localData.objectForKey("Dollars") as! Int
}

func updateHighScoreToGameData(score: Int) {
    guard let existingHighScore: Int = localData.objectForKey("HighScore") as? Int else {
        
        localData.setInteger(score, forKey: "HighScore")
        localData.synchronize()
        return
    }
    
    let newHighScore = (score > existingHighScore) ? score : existingHighScore
    GameHighScore = newHighScore
    
    localData.setInteger(newHighScore, forKey: "HighScore")
    localData.synchronize()
}

func getHighScoreFromGameData() -> Int {
    guard let highScore = localData.objectForKey("HighScore") as? Int else {
        
        localData.setInteger(0, forKey: "HighScore")
        localData.synchronize()
        
        return localData.objectForKey("HighScore") as! Int
    }
    
    GameHighScore = highScore
    return highScore
}

func initializeScoreToGameData(score: Int) {
    guard let _ = localData.objectForKey("Score") as? Int else {
        
        localData.setInteger(score, forKey: "Score")
        localData.synchronize()
        return
    }
    
    GameScore = score
    
    localData.setInteger(GameScore, forKey: "Score")
    localData.synchronize()
}

func getScoreFromGameData() -> Int {
    guard let score = localData.objectForKey("Score") as? Int else {
        
        localData.setInteger(0, forKey: "Score")
        localData.synchronize()
        
        return localData.objectForKey("Score") as! Int
    }
    
    GameScore = score
    return score
}