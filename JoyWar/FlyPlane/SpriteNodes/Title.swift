//
//  Title.swift
//  FlyPlane
//
//  Created by Dexter on 06/05/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Title: SKSpriteNode {
    
    let title = SKTexture(imageNamed: "Title")
    
    init() {
        super.init(texture: title, color: UIColor(), size: CGSize(width: title.size().width / 1.6, height: title.size().height / 1.6))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func beginAnimation() {
        runAction(getTitleAnimationCurvePath())
    }
    
    func drawTitleAnimationCurvePath(coin: SKNode) -> CGPathRef {
        
        // Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(position.x, position.y))
        bezierPath.addLineToPoint(CGPointMake(position.x, position.y * 1.5))
        bezierPath.addLineToPoint(CGPointMake(position.x, position.y * 1.7))
        bezierPath.addLineToPoint(CGPointMake(position.x, position.y * 2))
        UIColor.blackColor().setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
        
        return bezierPath.CGPath
    }
    
    func getTitleAnimationCurvePath() -> SKAction {
        let path = drawTitleAnimationCurvePath(self)
        
        let followPath = SKAction.followPath(path, asOffset: false, orientToPath: false, duration: 0.7)
        
        return followPath
    }

    
}