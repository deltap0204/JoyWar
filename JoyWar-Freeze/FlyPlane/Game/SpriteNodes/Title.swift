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
    
    let title = SKTexture(image: #imageLiteral(resourceName: "Title"))
    
    init() {
        super.init(texture: title, color: UIColor(), size: CGSize(width: title.size().width / 5.0, height: title.size().height / 5.0))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func beginAnimation() {
        run(getTitleAnimationCurvePath())
    }
    
    func drawTitleAnimationCurvePath(_ coin: SKNode) -> CGPath {
        
        // Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: position.x, y: position.y))
        bezierPath.addLine(to: CGPoint(x: position.x, y: position.y * 1.5))
        bezierPath.addLine(to: CGPoint(x: position.x, y: position.y * 1.7))
        bezierPath.addLine(to: CGPoint(x: position.x, y: position.y * 2))
        UIColor.black.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
        
        return bezierPath.cgPath
    }
    
    func getTitleAnimationCurvePath() -> SKAction {
        let path = drawTitleAnimationCurvePath(self)
        
        let followPath = SKAction.follow(path, asOffset: false, orientToPath: false, duration: 0.7)
        
        return followPath
    }

    
}
