//
//  Road.swift
//  FlyPlane
//
//  Created by Dexter on 23/04/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Road: SKSpriteNode {
    
    let road = SKTexture(image: #imageLiteral(resourceName: "PinkRoad"))
    var isAnimating = Bool()
    
    init() {
        super.init(texture: nil, color: UIColor(), size: CGSize(width: road.size().width, height: road.size().height - (road.size().height * (1 / 4))))
        
        anchorPoint = CGPoint(x: 0.0, y: 0.0)
        position = CGPoint(x: 0.0, y: 0.0)
        zPosition = 1
        
        /*  Stacking MovingMountainsTexture horizontally from Left To Right */
        let repeatingRoads: Int = 11
        for roadOrderCount:Int in 0 ..< repeatingRoads {
            
            let roadNode = SKSpriteNode(texture: road)
            
            roadNode.anchorPoint = CGPoint(x: 0.0, y: 0.0)
            roadNode.size = CGSize(width: road.size().width, height: road.size().height - (road.size().height * (1 / 4)))
            roadNode.position = CGPoint(x: CGFloat(roadOrderCount) * roadNode.size.width, y: 0)
            roadNode.zPosition = 0
            
            addChild(roadNode)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func beginAnimation() {
        
        if isAnimating == false {
            
            let speed: CGFloat = 10 / 1000 /* Moving speed is 4% percent */
            
            let moveroadRightToLeftAction = SKAction.moveBy(x: -road.size().width, y: 0, duration: TimeInterval(speed * road.size().width))
            let resetRoadLeftToRightAction = SKAction.moveBy(x: road.size().width, y: 0, duration: 0.0)
            let movingroadActionSequence = SKAction.sequence([moveroadRightToLeftAction, resetRoadLeftToRightAction])
            
            run(SKAction.repeatForever(movingroadActionSequence))
        }
    }
    
}
