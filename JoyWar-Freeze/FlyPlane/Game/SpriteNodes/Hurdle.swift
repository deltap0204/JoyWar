//
//  Stick.swift
//  FlyPlane
//
//  Created by Dexter on 24/04/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Hurdle : CrashableNode {
    
    
    // MARK: Properties
    
    let hurdleAtTop = SKTexture(image: #imageLiteral(resourceName: "HurdleAnimation0"))
    let hurdleAtBottom = SKTexture(image: #imageLiteral(resourceName: "HurdleAnimationInverce0"))
    
    var isHurdleInversed = Bool()
    var isAnimating = Bool()
    
    var connectedHurdleCandy: HurdleCandy? {
        didSet{
            guard connectedHurdleCandy != nil else {
                return
            }
            animationPosition = connectedHurdleCandy!.position.y
        }
    }
    
    var animationPosition = CGFloat()
    
    
    // MARK: Lifecycle
    
    init(isUpsideDown: Bool) {
        
        super.init(texture: isUpsideDown ? hurdleAtTop : hurdleAtBottom, color: UIColor(),
                   size: CGSize(width: hurdleAtTop.size().width, height: hurdleAtTop.size().height*1.4))
        maxHealth = 100
        isHurdleInversed = isUpsideDown
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width*0.6,
                                                             height: size.height))
        
        self.physicsBody?.isDynamic = false;
        self.physicsBody?.categoryBitMask = Categories.hurdle.rawValue
        zPosition = 0
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Crashable
    
    override func beginCrashAnimation(withCompletion completion: (()->())?) {
        super.beginCrashAnimation(withCompletion: nil)
        
        var animationFrames = [SKTexture]()
        let frameNameBase = isHurdleInversed ? "HurdleAnimation" : "HurdleAnimationInverce"

        for i in 0...28 {
            animationFrames.append(SKTexture(image: UIImage(named: "\(frameNameBase)\(i)")!))
        }

        self.physicsBody = nil
        connectedHurdleCandy?.connectedHurdle = nil
        connectedHurdleCandy?.healthIndicator.isHidden = true
        self.healthIndicator.isHidden = true
        connectedHurdleCandy?.beginCrashAnimation(withCompletion: nil)
        
        let bombAnimation = SKAction.animate(with: animationFrames, timePerFrame: 0.08)
        
        let removingAction = SKAction.run { [weak self] in
            self?.removeFromParent()
            completion?()
        }
        
        run(SKAction.sequence([bombAnimation, removingAction]))
    }
}


