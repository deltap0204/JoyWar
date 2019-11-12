//
//  GameData.swift
//  FlyPlane
//
//  Created by Dexter on 30/04/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation

var GameScore : NSInteger = 0
var GameHighScore = NSInteger()
var isAdBlocked: Bool = localData.bool(forKey: "isAdBlocked"){
    didSet{
        localData.set(isAdBlocked, forKey: "isAdBlocked")
        localData.synchronize()
    }
}

var isTutorialShowedFirstTimeGameScene: Bool = localData.bool(forKey: "isTutorialShowedFirstTimeGameScene") {
    didSet {
        localData.set(isTutorialShowedFirstTimeGameScene, forKey: "isTutorialShowedFirstTimeGameScene")
        localData.synchronize()
    }
}

var isBonusGivenForOneTime: Bool = localData.bool(forKey: "isBonusGivenForOneTime") {
    didSet {
        localData.set(isBonusGivenForOneTime, forKey: "isBonusGivenForOneTime")
        localData.synchronize()
    }
}

var GameMuteState: Bool {
    set{
        AudioPlayer.shared.isMuted = newValue
    }
    get{
        return AudioPlayer.shared.isMuted
    }
}
var localData: UserDefaults = UserDefaults.standard
