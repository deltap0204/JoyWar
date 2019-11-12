//
//  ProgressBar.swift
//  FlyPlane
//
//  Created by Dexter on 22/07/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class ProgressBar : SKSpriteNode {
    
    let progressBar = SKTexture(imageNamed: "ProgressBar")
    
    var isShown = Bool()
    
    init() {
        
        super.init(texture: progressBar, color: UIColor(), size: CGSize(width: (progressBar.size().width / 2), height: (progressBar.size().height / 2)))
        
        zPosition = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func beginAnimation() {
        
        if !isShown {
            let rotateAction = SKAction.rotateByAngle(CGFloat(M_PI / 4.0), duration: 0.25)
            runAction(SKAction.repeatActionForever(rotateAction))
        }
        
    }
    
}