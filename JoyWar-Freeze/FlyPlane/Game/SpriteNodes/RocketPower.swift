//
//  RocketPower.swift
//  Game
//
//  Created by Developer on 12.07.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import UIKit
import SpriteKit

class RocketPower: BaseSuperPower {

    let rocketPower = SKTexture(image: #imageLiteral(resourceName: "RocketLauncher"))
    
    init() {
        super.init(texture: rocketPower, color: UIColor(), size: CGSize(width: rocketPower.size().width / 8, height: rocketPower.size().height / 8))
        powerType = .rocket
        collectAnimation = beginShrinkAnimation
        physicsBody?.collisionBitMask = Categories.hurdle.rawValue | Categories.world.rawValue
    }
    
    init(type: RocketType) {
        
        var texture = SKTexture()
        
        switch type {
        case .type1:
            texture = SKTexture(imageNamed: "Roket_1_X1")
            break
        case .type2:
            texture = SKTexture(imageNamed: "Roket_2_X1")
            break
        case .type3:
            texture = SKTexture(imageNamed: "Roket_3_X1")
            break
        case .type4:
            texture = SKTexture(imageNamed: "Roket_4_X1")
            break
        case .type5:
            texture = SKTexture(imageNamed: "Roket_5_X1")
            break
        }
        
        super.init(texture: texture, color: UIColor(), size: CGSize(width: texture.size().width / 7, height: texture.size().height / 7))
        powerType = .rocket
        rocketType = type
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

