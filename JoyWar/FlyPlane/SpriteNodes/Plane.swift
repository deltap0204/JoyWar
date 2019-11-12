//
//  Plane.swift
//  FlyPlane
//
//  Created by Dexter on 22/04/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Plane: SKSpriteNode {
    
    let plane = SKTexture(imageNamed: "fly_01")
    let bubble = Bubble()
    
    init() {
        super.init(texture: plane, color: UIColor(), size: CGSize(width: plane.size().width / 5, height: plane.size().height / 5))
        zPosition = 1
        
        bubble.zPosition = 0
        bubble.beginShrinkAnimation()
        addChild(bubble)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func beginAnimation() {
        
        let fly1 = SKTexture(imageNamed: "fly_01")
        let fly2 = SKTexture(imageNamed: "fly_02")
        let fly3 = SKTexture(imageNamed: "fly_03")
        let fly4 = SKTexture(imageNamed: "fly_04")
        let fly5 = SKTexture(imageNamed: "fly_05")
        let fly6 = SKTexture(imageNamed: "fly_06")
        let fly7 = SKTexture(imageNamed: "fly_07")
        let fly8 = SKTexture(imageNamed: "fly_08")
        let fly9 = SKTexture(imageNamed: "fly_09")
        let fly10 = SKTexture(imageNamed: "fly_10")
        let fly11 = SKTexture(imageNamed: "fly_11")
        let fly12 = SKTexture(imageNamed: "fly_12")
        let fly13 = SKTexture(imageNamed: "fly_13")
        let fly14 = SKTexture(imageNamed: "fly_14")
        let fly15 = SKTexture(imageNamed: "fly_15")
        let fly16 = SKTexture(imageNamed: "fly_16")
        let fly17 = SKTexture(imageNamed: "fly_17")
        let fly18 = SKTexture(imageNamed: "fly_18")
        let fly19 = SKTexture(imageNamed: "fly_19")
        let fly20 = SKTexture(imageNamed: "fly_20")
        let fly21 = SKTexture(imageNamed: "fly_21")
        let fly22 = SKTexture(imageNamed: "fly_22")
        let fly23 = SKTexture(imageNamed: "fly_23")
        let fly24 = SKTexture(imageNamed: "fly_24")
        let fly25 = SKTexture(imageNamed: "fly_25")
        
        let planeFlyingAnimation = SKAction.animateWithTextures([ fly1, fly2, fly3, fly4, fly5, fly6, fly7, fly8, fly9, fly10, fly11, fly12, fly13, fly14, fly15, fly16, fly17, fly18, fly19, fly20, fly21, fly22, fly23, fly24, fly25 ], timePerFrame: 0.035)
        
        runAction(SKAction.repeatActionForever(planeFlyingAnimation))
    }    
    
    func beginAlphaAnimation(isGameScene: Bool) {
        let alphaFull = SKAction.fadeAlphaTo(1.0, duration: 0.1)
        let alpha3By4 = SKAction.fadeAlphaTo(0.7, duration: 0.1)
        let alpha1By2 = SKAction.fadeAlphaTo(0.4, duration: 0.1)
        let alpha1By1 = SKAction.fadeAlphaTo(0.0, duration: 0.1)
        var alphaSequence = SKAction()
        
        if isGameScene {
            alphaSequence = SKAction.sequence([alpha1By1, alpha1By2, alpha3By4, alphaFull])
        } else {
            alphaSequence = SKAction.sequence([alpha3By4, alpha1By2, alpha1By1])
        }
        
        runAction(alphaSequence)
    }
    
    func beginStartUpAnimation() {
        runAction(getPlanePathForAnimation())
    }
    
    func drawCoinAnimationCurvePath(coin: SKNode) -> CGPathRef {
        
        // Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(317.5, 396.5))
        bezierPath.addLineToPoint(CGPointMake(343.29, 396.5))
        bezierPath.addCurveToPoint(CGPointMake(391.11, 396.5), controlPoint1: CGPointMake(343.29, 396.5), controlPoint2: CGPointMake(362.51, 462.5))
        bezierPath.addCurveToPoint(CGPointMake(437.53, 396.5), controlPoint1: CGPointMake(419.72, 330.5), controlPoint2: CGPointMake(437.53, 396.5))
        bezierPath.addCurveToPoint(CGPointMake(490.99, 396.5), controlPoint1: CGPointMake(437.53, 396.5), controlPoint2: CGPointMake(460.04, 471.5))
        bezierPath.addCurveToPoint(CGPointMake(556.16, 396.5), controlPoint1: CGPointMake(521.93, 321.5), controlPoint2: CGPointMake(556.16, 396.5))
        bezierPath.addCurveToPoint(CGPointMake(626.49, 396.5), controlPoint1: CGPointMake(556.16, 396.5), controlPoint2: CGPointMake(588.05, 527.5))
        bezierPath.addCurveToPoint(CGPointMake(679.48, 396.5), controlPoint1: CGPointMake(664.94, 265.5), controlPoint2: CGPointMake(679.48, 396.5))
        bezierPath.addCurveToPoint(CGPointMake(747.93, 396.5), controlPoint1: CGPointMake(679.48, 396.5), controlPoint2: CGPointMake(714.18, 490.5))
        bezierPath.addCurveToPoint(CGPointMake(832.8, 396.5), controlPoint1: CGPointMake(781.69, 302.5), controlPoint2: CGPointMake(832.8, 396.5))
        bezierPath.addLineToPoint(CGPointMake(867.5, 396.5))
        UIColor.blackColor().setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()

        return bezierPath.CGPath
    }
    
    func getPlanePathForAnimation() -> SKAction {
        let path = drawCoinAnimationCurvePath(self)
        
        let followPath = SKAction.followPath(path, asOffset: false, orientToPath: false, duration: 12.5)
        
        let repeatAnimation = SKAction.repeatActionForever(followPath)
        
        return repeatAnimation
    }

}