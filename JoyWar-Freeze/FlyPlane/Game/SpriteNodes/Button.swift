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
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    init(imageNamed: String) {
        button = SKTexture(imageNamed: imageNamed)
        super.init(texture: button, color: UIColor(), size: button.size())
        zPosition = 1
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }    
    
    func beginAnimation() {
        let scale1By1 = SKAction.scale(to: 1.0, duration: 0.05)
        let scale3By4 = SKAction.scale(to: 0.90, duration: 0.05)
        let scale1By2 = SKAction.scale(to: 0.75, duration: 0.05)
        let scaleSequence = SKAction.sequence([scale3By4, scale1By2, scale3By4, scale1By1])
        run(scaleSequence)
    }
    
    func iAPButtonBeginAnimation() {
        let scale1By1 = SKAction.scale(to: 0.5, duration: 0.05)
        let scale3By4 = SKAction.scale(to: 0.4, duration: 0.05)
        let scale1By2 = SKAction.scale(to: 0.3, duration: 0.05)
        let scaleSequence = SKAction.sequence([scale3By4, scale1By2, scale3By4, scale1By1])
        run(scaleSequence)
    }
    
    func beginAlphaAnimation() {
        let alpha3By4 = SKAction.fadeAlpha(to: 0.7, duration: 0.1)
        let alpha1By2 = SKAction.fadeAlpha(to: 0.4, duration: 0.1)
        let alpha1By1 = SKAction.fadeAlpha(to: 0.0, duration: 0.1)
        let alphaSequence = SKAction.sequence([alpha3By4, alpha1By2, alpha1By1])
        run(alphaSequence)
    }
    
    func beginSoundAnimation() {
        let scale1By1 = SKAction.scale(to: 0.65, duration: 0.05)
        let scale3By4 = SKAction.scale(to: 0.60, duration: 0.05)
        let scale1By2 = SKAction.scale(to: 0.55, duration: 0.05)
        let scaleSequence = SKAction.sequence([scale3By4, scale1By2, scale3By4, scale1By1])
        run(scaleSequence)
    }
    
    func beginSoundAlphaAnimation() {
        let alpha3By4 = SKAction.fadeAlpha(to: 0.45, duration: 0.1)
        let alpha1By2 = SKAction.fadeAlpha(to: 0.25, duration: 0.1)
        let alpha1By1 = SKAction.fadeAlpha(to: 0.0, duration: 0.1)
        let alphaSequence = SKAction.sequence([alpha3By4, alpha1By2, alpha1By1])
        run(alphaSequence)
    }
    
    func beginSocialNetWorkingAnimation() {
        let scale1By1 = SKAction.scale(to: 0.60, duration: 0.05)
        let scale3By4 = SKAction.scale(to: 0.45, duration: 0.05)
        let scale1By2 = SKAction.scale(to: 0.35, duration: 0.05)
        let scaleSequence = SKAction.sequence([scale3By4, scale1By2, scale3By4, scale1By1])
        run(scaleSequence)
    }
    
    func beginBubbleAnimation() {
        let scale1By1 = SKAction.scale(to: 0.60, duration: 0.05)
        let scale3By4 = SKAction.scale(to: 0.45, duration: 0.05)
        let scale1By3 = SKAction.scale(to: 0.60, duration: 0.10)
        let scale1By2 = SKAction.scale(to: 0.35, duration: 0.05)
        let scaleSequence =  SKAction.repeatForever(SKAction.sequence([scale3By4, scale1By2, scale1By3, scale3By4, scale1By1]))
        run(scaleSequence)
    }
}
