//
//  HighScoreManager.swift
//  FlyPlane
//
//  Created by Dexter on 30/04/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation

class HighScoreManager {
    
    static var score: NSInteger!
    
    static func manageHighScore() -> Bool {
        
        var isHighScoreUpdated: Bool = false
        
        initializeHighScore()
        
        GameHighScore = localData.integerForKey("GameHighestScore")
        
        if score > GameHighScore {
            
            localData.setInteger(score, forKey: "GameHighestScore")
            localData.synchronize()
            
            isHighScoreUpdated = true
        }
        
        return isHighScoreUpdated
    }
    
    static func initializeHighScore() {
        guard let _ = localData.objectForKey("GameHighestScore") else {
            localData.setInteger(0, forKey: "GameHighestScore")
            localData.synchronize()
            return
        }
    }
    
}