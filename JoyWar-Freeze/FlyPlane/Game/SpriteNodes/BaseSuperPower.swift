//
//  BaseSuperPower.swift
//  Game
//
//  Created by Daniel Slupskiy on 01.04.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import UIKit
import SpriteKit

class BaseSuperPower: SKSpriteNode {
    
    var powerType = SuperPowers.unspecified
    var rocketType: RocketType!
    var bulletCount: Int!
    var collectAnimation: (()->())?
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        zPosition = 1
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody!.isDynamic = false
        physicsBody!.affectedByGravity = false
        physicsBody!.categoryBitMask = Categories.superPower.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func beginAnimation() {
        let sizeShrink = SKAction.scale(to: 2.0, duration: 0.5)
        let sizeExpand = SKAction.scale(to: 2.5, duration: 0.5)
        let sizeVarientSequence = SKAction.sequence([sizeShrink, sizeExpand])
        run(SKAction.repeatForever(sizeVarientSequence))
    }
    
    func beginShrinkAnimation() -> Void {
        let size3by4 = SKAction.scale(to: 0.75, duration: 0.1)
        let size1by2 = SKAction.scale(to: 0.50, duration: 0.1)
        let size1by4 = SKAction.scale(to: 0.25, duration: 0.1)
        let size0by1 = SKAction.scale(to: 0.00, duration: 0.1)
        let sizeShrinkSequence = SKAction.sequence([size3by4, size1by2, size1by4, size0by1])
        let remove = SKAction.removeFromParent()
        run(SKAction.sequence([sizeShrinkSequence, remove]))
        //removeFromParent()
    }
    
    func beginExpandAnimation() -> Void {
        let size0by1 = SKAction.scale(to: 0.00, duration: 0.1)
        let size1by4 = SKAction.scale(to: 0.25, duration: 0.1)
        let size1by2 = SKAction.scale(to: 0.50, duration: 0.1)
        let size3by4 = SKAction.scale(to: 0.75, duration: 0.1)
        let size1by1 = SKAction.scale(to: 1.00, duration: 0.1)
        let sizeExpandSequence = SKAction.sequence([size0by1, size1by4, size1by2, size3by4, size1by1])
        run(sizeExpandSequence)
    }
    
    func beginAlphaAnimation(_ isGameScene: Bool) {
        let alphaFull = SKAction.fadeAlpha(to: 1.0, duration: 0.1)
        let alpha3By4 = SKAction.fadeAlpha(to: 0.7, duration: 0.1)
        let alpha1By2 = SKAction.fadeAlpha(to: 0.4, duration: 0.1)
        let alpha1By1 = SKAction.fadeAlpha(to: 0.0, duration: 0.1)
        var alphaSequence = SKAction()
        
        if isGameScene {
            alphaSequence = SKAction.sequence([alpha1By1, alpha1By2, alpha3By4, alphaFull])
        } else {
            alphaSequence = SKAction.sequence([alpha3By4, alpha1By2, alpha1By1])
        }
        
        run(alphaSequence)
    }
}
