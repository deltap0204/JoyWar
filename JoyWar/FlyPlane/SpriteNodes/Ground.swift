//
//  Ground.swift
//  FlyPlane
//
//  Created by Dexter on 23/04/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Ground: SKSpriteNode {
    
    let ground = SKTexture(imageNamed: "Ground")
    var isAnimating = Bool()
    
    init() {
        super.init(texture: nil, color: UIColor(), size: CGSize(width: ground.size().width , height: ground.size().height - (ground.size().height * (1 / 4))))
        
        anchorPoint = CGPoint(x: 0.0, y: 0.0)
        position = CGPoint(x: 0.0, y: 0.0)
        zPosition = 1
        
        /*  Stacking MovingMountainsTexture horizontally from Left To Right */
        let repeatingGrounds: Int = 11
        for groundOrderCount:Int in 0 ..< repeatingGrounds {
            
            let groundNode = SKSpriteNode(texture: ground)
            
            groundNode.anchorPoint = CGPoint(x: 0.0, y: 0.0)
            groundNode.size = CGSize(width: ground.size().width, height: ground.size().height - (ground.size().height * (1 / 4)))
            groundNode.position = CGPoint(x: CGFloat(groundOrderCount) * groundNode.size.width, y: 0)
            groundNode.zPosition = 0
            
            addChild(groundNode)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func beginAnimation() {
        
        if isAnimating == false {
            
            let speed: CGFloat = 10 / 1000 /* Moving speed is 4% percent */
            
            let moveGroundRightToLeftAction = SKAction.moveByX(-ground.size().width, y: 0, duration: NSTimeInterval(speed * ground.size().width))
            let resetGroundLeftToRightAction = SKAction.moveByX(ground.size().width, y: 0, duration: 0.0)
            let movingGroundActionSequence = SKAction.sequence([moveGroundRightToLeftAction, resetGroundLeftToRightAction])
            
            runAction(SKAction.repeatActionForever(movingGroundActionSequence))
        }
    }
    
}