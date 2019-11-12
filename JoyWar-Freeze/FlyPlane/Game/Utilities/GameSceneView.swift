//
//  GameSceneView.swift
//  Game
//
//  Created by Daniel Slupskiy on 24.09.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import Foundation
import SpriteKit

class GameSceneView: SKView {
    
    var sceneShouldBePaused = false
    
    func CBApplicationDidBecomeActive()
    {
        //print("sceneShouldBePaused ", sceneShouldBePaused)
        self.isPaused = self.sceneShouldBePaused
    }
}
