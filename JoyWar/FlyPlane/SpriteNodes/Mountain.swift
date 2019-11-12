//
//  Mountain.swift
//  FlyPlane
//
//  Created by Dexter on 23/04/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Mountain: SKSpriteNode {
    
    let mountain = SKTexture(imageNamed: "Mountain")
    var isAnimating = Bool()
    
    init() {
        super.init(texture: nil, color: UIColor(), size: CGSize(width: mountain.size().width, height: mountain.size().height - (mountain.size().height * (1 / 4))))
        
        anchorPoint = CGPoint(x: 0.0, y: 0.0)
        position = CGPoint(x: 0.0, y: 0.0)
        zPosition = 0
        
        /*  Stacking MovingMountainsTexture horizontally from Left To Right */
        let mountainmountains: Int = 11
        for mountainOrderCount:Int in 0 ..< mountainmountains {
            
            let mountainNode = SKSpriteNode(texture: mountain)
            
            mountainNode.anchorPoint = CGPoint(x: 0.0, y: 0.0)
            mountainNode.size = CGSize(width: mountain.size().width, height: mountain.size().height - (mountain.size().height * (1 / 4)))
            mountainNode.position = CGPoint(x: CGFloat(mountainOrderCount) * mountainNode.size.width, y: 0)
            mountainNode.zPosition = 0
            
            addChild(mountainNode)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func beginAnimation() {
        
        if isAnimating == false {
            
            let speed: CGFloat = 4 / 200 /* Moving speed is 7% percent */
            
            let moveMountainRightToLeftAction = SKAction.moveByX(-mountain.size().width, y: 0, duration: NSTimeInterval(speed * mountain.size().width))
            let resetMountainLeftToRightAction = SKAction.moveByX(mountain.size().width, y: 0, duration: 0.0)
            let movingMountainActionSequence = SKAction.sequence([moveMountainRightToLeftAction, resetMountainLeftToRightAction])
            
            runAction(SKAction.repeatActionForever(movingMountainActionSequence))
        }
    }
    
}