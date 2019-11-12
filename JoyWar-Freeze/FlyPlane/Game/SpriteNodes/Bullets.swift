//
//  Bullets.swift
//  Game
//
//  Created by Developer on 12.07.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import UIKit
import SpriteKit

class Bullets: BaseSuperPower {
    
    let bullets = SKTexture(imageNamed: "BulletX10")
    
    init() {
        super.init(texture: bullets, color: UIColor(), size: CGSize(width: bullets.size().width / 4, height: bullets.size().height / 4))
        powerType = .bullets
        collectAnimation = beginShrinkAnimation
        physicsBody?.collisionBitMask = Categories.hurdle.rawValue | Categories.world.rawValue
    }
    
    init(multiplierId: Int){
        
        var texture = SKTexture()
        
        switch multiplierId {
        case 0:
            texture = SKTexture(imageNamed: "BulletX10")
            break
        case 1:
            texture = SKTexture(imageNamed: "BulletX25")
            break
        default:
            break
        }
        
        super.init(texture: texture, color: UIColor(), size: CGSize(width: texture.size().width / 2.5, height: texture.size().height / 2.5))
        powerType = .bullets
        bulletCount = multiplierId == 0 ? 10 : 25
        collectAnimation = beginShrinkAnimation
        physicsBody?.collisionBitMask = Categories.hurdle.rawValue | Categories.world.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func upAndDownAnimation() -> Void {
        self.position = CGPoint(x: 0, y: 400.0/2 - 50)
        
        let moveUp = SKAction.moveTo(y: self.position.y + 30, duration: 0.7)
        let moveDown = SKAction.moveTo(y: self.position.y - 30, duration: 0.7)
        let moveUpAndDown = SKAction.repeatForever(SKAction.sequence([moveUp, moveDown]))
        
        self.run(moveUpAndDown)
    }
}
