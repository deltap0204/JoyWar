//
//  PathFinder.swift
//  Game
//
//  Created by Developer on 17.05.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class PathFinder: SKSpriteNode {
    
    let pathTexture = SKTexture(image: #imageLiteral(resourceName: "PathFinderAnimation0"))
    
    init() {
        super.init(texture: pathTexture, color: UIColor(), size: CGSize(width: pathTexture.size().width,
                                                                        height: pathTexture.size().height))
    
        physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitMask = Categories.pathFinder.rawValue
        physicsBody?.collisionBitMask = Categories.score.rawValue
    
        beginAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveTo(yPoint : CGFloat?){
        if let destinationY = yPoint{
            run(SKAction.moveTo(y: destinationY, duration: 0.5))
            if let scene = self.parent as? GameScene{
                scene.queueOfPathForBaloon.enqueue(destinationY+75)
            }
            
           }
        else { delay(1, closure: {
            if let scene = self.parent as? GameScene{
                self.moveTo(yPoint: scene.queueOfPathYPoints.dequeue()?.0)
            }
            
        })
            
        }
    }
    
    func beginAnimation() {
        var animationFrames = [SKTexture]()
        for i in 0...7 {
            animationFrames.append(SKTexture(image: UIImage(named: "PathFinderAnimation\(i)")!))
        }
        
        texture = animationFrames[0]
        size = CGSize(width: animationFrames[0].size().width/2,
                      height: animationFrames[0].size().height/2)
        
        self.physicsBody = nil
        let pathFinderAnimation = SKAction.animate(with: animationFrames, timePerFrame: 0.1)
        run(SKAction.repeatForever(pathFinderAnimation))
    }
    
}
