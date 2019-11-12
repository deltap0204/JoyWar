//
//  CandyToDollars.swift
//  FlyPlane
//
//  Created by Dexter on 10/05/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class CandyToDollars: SKSpriteNode {
    
    let dollarSymbol = SKSpriteNode(imageNamed: "DollarSymbol")
    var dollarDigit = SKSpriteNode(imageNamed: "0")
    var dollar = Int()
    
    init() {
        super.init(texture: nil, color: UIColor(), size: CGSize(width: dollarSymbol.size.width + dollarDigit.size.width, height: dollarDigit.size.height))
            
        dollarDigit.size = CGSize(width: dollarDigit.size.width, height: dollarDigit.size.height)
        dollarDigit.position = CGPoint(x: 0.0, y: 0.0)
        addChild(dollarDigit)
        
        dollarSymbol.size = CGSize(width: dollarSymbol.size.width / 2.5, height: dollarSymbol.size.height / 2.5)
        dollarSymbol.position = CGPoint(x: dollarDigit.size.width * 0.75, y: dollarDigit.size.height)
        addChild(dollarSymbol)
        
        zPosition = 1
        
        hidden = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func beginAnimation() {
        let moveUp = SKAction.moveToY(position.y + 34.0, duration: 0.5)
        let fadeOut = SKAction.fadeOutWithDuration(0.3)
        let animation = SKAction.group([moveUp, fadeOut])
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([animation, remove])
        runAction(sequence)
    }
    
    func updateScoresCount() {
        dollarDigit.texture = SKTexture(imageNamed: "\(dollar)")
    }

}