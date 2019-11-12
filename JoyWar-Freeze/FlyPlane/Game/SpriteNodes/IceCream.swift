//
//  IceCream.swift
//  Game
//
//  Created by Developer on 27.05.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import Foundation

import Foundation
import UIKit
import SpriteKit

class IceCream: SKSpriteNode {
    
    
    // MARK: Properties
    let iceCreamTexture = SKTexture(image: #imageLiteral(resourceName: "icecream-1"))
    let shift: CGFloat
    let shiftDuration: TimeInterval
    
    // MARK: Lifecycle
    
    init() {
        
//        let random = Int.random(range: 0...2)
//        
//        switch random {
//        case 0:
            shift = iceCreamTexture.size().height*0.25
            shiftDuration = 0.25
//        default:
//            shift = iceCreamTexture.size().height*0.5
//            shiftDuration = 0.5
//        }

        
        super.init(texture: iceCreamTexture,
                   color: UIColor(),
                   size: CGSize(width: iceCreamTexture.size().width,
                                height: iceCreamTexture.size().height - shift))
        
        zPosition = 0
        
        
        name = "iceCream"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func beginAnimation() {
        

        
        let numberOfSteps = 6
        let shiftStep = shift/CGFloat(numberOfSteps)
        let shiftStepDuration = shiftDuration/Double(numberOfSteps)
        position.y -= shift/2
        
        let upResizeAnimationStep = SKAction.resize(byWidth: 0, height: shiftStep, duration: shiftStepDuration)
        let upMoveAnimationStep = SKAction.moveBy(x: 0, y: shiftStep/2, duration: shiftStepDuration)
        let upAnimationStep = SKAction.group([upResizeAnimationStep, upMoveAnimationStep])
        
        let downResizeAnimationStep = SKAction.resize(byWidth: 0, height: -shiftStep, duration: shiftStepDuration)
        let downMoveAnimationStep = SKAction.moveBy(x: 0, y: -shiftStep/2, duration: shiftStepDuration)
        let downAnimationStep = SKAction.group([downResizeAnimationStep, downMoveAnimationStep])
        
        let physicsBodyFix = SKAction.run {
            self.recreatePhysicsBody()
        }
        
        var upAnimationArray = [SKAction]()
        var downAnimationArray = [SKAction]()
        
        for i in 0..<Int(numberOfSteps) {
            upAnimationArray.append(upAnimationStep)
            
            upAnimationArray.append(physicsBodyFix)
            downAnimationArray.append(downAnimationStep)
            downAnimationArray.append(physicsBodyFix)
        }
        
        let upAnimation = SKAction.sequence(upAnimationArray)
        let downAnimation = SKAction.sequence(downAnimationArray)
           
        
        run(SKAction.repeatForever(SKAction.sequence([upAnimation, downAnimation])))
    }
    
    private func recreatePhysicsBody() {
        physicsBody = SKPhysicsBody(texture: iceCreamTexture, size: CGSize(width: size.width,
                                                                           height: size.height))
        physicsBody!.categoryBitMask = Categories.nonDestroyableHurdle.rawValue
        physicsBody!.isDynamic = false
        physicsBody!.affectedByGravity = false
        
    }
}
