//
//  Button.swift
//  FlyPlane
//
//  Created by Dexter on 06/05/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Button: SKSpriteNode {
    
    var button = SKTexture(imageNamed: "nil")
    
    init(imageNamed: String) {
        button = SKTexture(imageNamed: imageNamed)
        super.init(texture: button, color: UIColor(), size: button.size())
        zPosition = 1
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }    
    
    func beginAnimation() {
        let scale1By1 = SKAction.scaleTo(1.0, duration: 0.05)
        let scale3By4 = SKAction.scaleTo(0.90, duration: 0.05)
        let scale1By2 = SKAction.scaleTo(0.75, duration: 0.05)
        let scaleSequence = SKAction.sequence([scale3By4, scale1By2, scale3By4, scale1By1])
        runAction(scaleSequence)
    }
    
    func beginAlphaAnimation() {
        let alpha3By4 = SKAction.fadeAlphaTo(0.7, duration: 0.1)
        let alpha1By2 = SKAction.fadeAlphaTo(0.4, duration: 0.1)
        let alpha1By1 = SKAction.fadeAlphaTo(0.0, duration: 0.1)
        let alphaSequence = SKAction.sequence([alpha3By4, alpha1By2, alpha1By1])
        runAction(alphaSequence)
    }
    
    func beginSoundAnimation() {
        let scale1By1 = SKAction.scaleTo(0.65, duration: 0.05)
        let scale3By4 = SKAction.scaleTo(0.60, duration: 0.05)
        let scale1By2 = SKAction.scaleTo(0.55, duration: 0.05)
        let scaleSequence = SKAction.sequence([scale3By4, scale1By2, scale3By4, scale1By1])
        runAction(scaleSequence)
    }
    
    func beginSoundAlphaAnimation() {
        let alpha3By4 = SKAction.fadeAlphaTo(0.45, duration: 0.1)
        let alpha1By2 = SKAction.fadeAlphaTo(0.25, duration: 0.1)
        let alpha1By1 = SKAction.fadeAlphaTo(0.0, duration: 0.1)
        let alphaSequence = SKAction.sequence([alpha3By4, alpha1By2, alpha1By1])
        runAction(alphaSequence)
    }
    
    func beginSocialNetWorkingAnimation() {
        let scale1By1 = SKAction.scaleTo(0.50, duration: 0.05)
        let scale3By4 = SKAction.scaleTo(0.45, duration: 0.05)
        let scale1By2 = SKAction.scaleTo(0.35, duration: 0.05)
        let scaleSequence = SKAction.sequence([scale3By4, scale1By2, scale3By4, scale1By1])
        runAction(scaleSequence)
    }
}