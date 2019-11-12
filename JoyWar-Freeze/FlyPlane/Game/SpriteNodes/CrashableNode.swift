//
//  CrashableNode.swift
//  Game
//
//  Created by Developer on 21.04.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

enum hurdleCandyPricing{
    case iceStick
    case joyStick
    case hurdleCandy
    case lolipop
    
    var priceInCoin:Int{
        switch self {
        case .iceStick:
            return 1
        case .joyStick:
            return 2
        case .hurdleCandy:
            return 5
        case .lolipop:
            return 7
        }
    
    }


}

class CrashableNode: SKSpriteNode, Damagable, Crashable {
    
    
    // MARK: Properties
    
    let healthIndicator = ProgressNode(radius: 14,
                                       color: SKColor.green,
                                       backgroundColor: SKColor.clear,
                                       width: 5,
                                       progress: 1.0)
    var maxHealth: CGFloat = 0 {
        didSet {
            health = maxHealth
          
        }
    }
    var health: CGFloat = 0 {
        didSet {
           updateHealth(oldHealth: oldValue)
        }
    }
    
    
    // MARK: Lifecycle
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        healthIndicator.position = CGPoint(x: 0, y: 0)
        healthIndicator.zPosition = 0
        
        if !(self is Rotating) {
         addChild(healthIndicator)
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Actions
    
    func beginCrashAnimation(withCompletion completion: (() -> ())?) {
        if let hardleWidthPrice = self as? Cashable{
            if let parentScene = self.scene as? GameScene{
                let candyToDollar = CandyToDollars()
                candyToDollar.dollar = hardleWidthPrice.price.priceInCoin
                
                if !(self is Rotating) {
                    self.addChild(candyToDollar)}
                else if parent != nil {
                    parent?.addChild(candyToDollar)
                    candyToDollar.position = position
                }
                candyToDollar.isHidden = false
                
                candyToDollar.updateScoresCount()
                candyToDollar.beginAnimation()
                
                updateDollarsToGameData(hardleWidthPrice.price.priceInCoin)
                parentScene.dollarWallet.updateDollarsCount()
                    
            }
            
        }
    }

    func updateHealth(oldHealth: CGFloat) {
        if health < oldHealth {
            healthIndicator.isHidden = false
            healthIndicator.progress = 1.0 - CGFloat(health / maxHealth)
        }
        if self.health <= 0  {
            healthIndicator.isHidden = true
            beginCrashAnimation(withCompletion: nil)
        }
    }
}
