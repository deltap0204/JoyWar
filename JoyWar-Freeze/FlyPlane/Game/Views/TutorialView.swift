//
//  TutorialView.swift
//  Game
//
//  Created by Developer on 12.10.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import Foundation
import SpriteKit

class TutorialView: UIView {
    var scene: SKScene?
    @IBOutlet weak var imageView: UIImageView!
    var currentIndex = 0
    let arrayImage :[UIImage] = [#imageLiteral(resourceName: "Baloon"),
                                 #imageLiteral(resourceName: "Patfinder"),
                                 #imageLiteral(resourceName: "Bubble"),
                                 #imageLiteral(resourceName: "Shot"),
                                 #imageLiteral(resourceName: "Rocket")]

    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    @IBAction func leftButtonWasPressed(_ sender: Any) {
        if currentIndex == 0 {
            currentIndex = 4
        } else {
            currentIndex -= 1
        }
        
        imageView.image = arrayImage[currentIndex]
    }

    @IBAction func closeButtonWasPressed(_ sender: Any) {
        self.removeFromSuperview()
        if let currentScene = self.scene as? GameScene{
            currentScene.tutorial = nil
            
            currentScene.pauseBackground.removeFromParent()
            currentScene.sceneResume()
        }
        if let currentScene = self.scene as? FrontScene{
            currentScene.tutorial = nil
            currentScene.pauseBackground.removeFromParent()
        }
    }
    
    @IBAction func rightButtonWasPressed(_ sender: Any) {
        if currentIndex == 4 {
            currentIndex = 0
        } else {
            currentIndex += 1
        }
        
        imageView.image = arrayImage[currentIndex]
    }
}
