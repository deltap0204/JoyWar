//
//  Bubble.swift
//  FlyPlane
//
//  Created by Dexter on 25/07/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Bubble: SKSpriteNode {
    let bubble = SKTexture(imageNamed: "bubble-256px")
    
    init() {
        super.init(texture: bubble, color: UIColor(), size: CGSize(width: bubble.size().width / 2.5, height: bubble.size().height / 2.5))
        zPosition = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func beginAnimation() {
        let sizeShrink = SKAction.scaleTo(0.75, duration: 0.1)
        let sizeExpand = SKAction.scaleTo(1.0, duration: 0.1)
        let sizeVarientSequence = SKAction.sequence([sizeShrink, sizeExpand])
        runAction(sizeVarientSequence)
    }
    
    func beginShrinkAnimation() -> Void {
        let size3by4 = SKAction.scaleTo(0.75, duration: 0.1)
        let size1by2 = SKAction.scaleTo(0.50, duration: 0.1)
        let size1by4 = SKAction.scaleTo(0.25, duration: 0.1)
        let size0by1 = SKAction.scaleTo(0.00, duration: 0.1)
        let sizeShrinkSequence = SKAction.sequence([size3by4, size1by2, size1by4, size0by1])
        runAction(sizeShrinkSequence)
    }
    
    func beginExpandAnimation() -> Void {
        let size0by1 = SKAction.scaleTo(0.00, duration: 0.1)
        let size1by4 = SKAction.scaleTo(0.25, duration: 0.1)
        let size1by2 = SKAction.scaleTo(0.50, duration: 0.1)
        let size3by4 = SKAction.scaleTo(0.75, duration: 0.1)
        let size1by1 = SKAction.scaleTo(1.00, duration: 0.1)
        let sizeExpandSequence = SKAction.sequence([size0by1, size1by4, size1by2, size3by4, size1by1])
        runAction(sizeExpandSequence)
    }
    
    func beginAlphaAnimation(isGameScene: Bool) {
        let alphaFull = SKAction.fadeAlphaTo(1.0, duration: 0.1)
        let alpha3By4 = SKAction.fadeAlphaTo(0.7, duration: 0.1)
        let alpha1By2 = SKAction.fadeAlphaTo(0.4, duration: 0.1)
        let alpha1By1 = SKAction.fadeAlphaTo(0.0, duration: 0.1)
        var alphaSequence = SKAction()
        
        if isGameScene {
            alphaSequence = SKAction.sequence([alpha1By1, alpha1By2, alpha3By4, alphaFull])
        } else {
            alphaSequence = SKAction.sequence([alpha3By4, alpha1By2, alpha1By1])
        }
        
        runAction(alphaSequence)
    }
}