//
//  FS - Charboost.swift
//  Game
//
//  Created by Паша on 04/08/2017.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import Foundation

extension FrontScene: ChartboostDelegate {
    
    func shouldDisplayRewardedVideo(location: String!) -> Bool {
        return true
    }
    
    func didCompleteRewardedVideo(_ location: String!, withReward reward: Int32) {
        updateDollarsToGameData(100)
        
        dollarWallet.updateDollarsCount()

        
        
        //print("**** you get 100$ ****")
        
    }
    
//    func didDisplayRewardedVideo(location: String!) {
//        
//    }
    
}
