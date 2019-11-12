//
//  GameViewController.swift
//  FlyPlane
//
//  Created by Dexter on 22/04/16.
//  Copyright (c) 2016 Studio2Entertainment. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController, PresentGameScene {
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        presentFrontScene()
    }
    
    func presentGameScene(isResuming: Bool) {
        if let scene = GameScene(fileNamed: "GameScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.showsPhysics = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = false
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            scene.isTheGamePaused = isResuming
            scene.protocolDelegate = self
            
            let transition = SKTransition.fadeWithDuration(0.0)
            skView.presentScene(scene, transition: transition)
        }
    }
    
    func presentFrontScene() {
        if let scene = FrontScene(fileNamed: "GameScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.showsPhysics = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = false
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            scene.protocolDelegate = self
            
            let transition = SKTransition.fadeWithDuration(0.0)
            skView.presentScene(scene, transition: transition)
        }
    }
    
    

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
