//
//  HurdleCandy.swift
//  FlyPlane
//
//  Created by Dexter on 24/04/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class HurdleCandy : CrashableNode, Rotating, Cashable{
    
    
    // MARK: Properties
    var price: hurdleCandyPricing = .hurdleCandy
    let hurdleCandy = SKTexture(image: #imageLiteral(resourceName: "HurdleCandy"))
    var isAnimating = Bool()
    
    
    // MARK: Lifecycle
    
    init() {
        super.init(texture: hurdleCandy, color: UIColor(),
                   size: CGSize(width: hurdleCandy.size().width - (hurdleCandy.size().width * (1 / 1.6)),
                                height: hurdleCandy.size().height - (hurdleCandy.size().height * (1 / 1.6))))
        
        maxHealth = 100
        zPosition = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var connectedHurdle: Hurdle?
    
    
    // MARK: Actions
    
    func beginRotating() {
        
        if !isAnimating {
            let rotateAction = SKAction.rotate(byAngle: CGFloat(Double.pi / 4.0), duration: 1.5)
            run(SKAction.repeatForever(rotateAction))
        }
    }
    
    
    // MARK: Crashable
    
    override func beginCrashAnimation(withCompletion completion: (()->())?) {
        
        super.beginCrashAnimation(withCompletion: nil)
        
        var animationFrames = [SKTexture]()
        for i in 0...19 {
            animationFrames.append(SKTexture(image: UIImage(named: "LollipopAnimation\(i)")!))
        }
        
        texture = animationFrames[0]
        size = CGSize(width: animationFrames[0].size().width,
                      height: animationFrames[0].size().height)
        
        self.physicsBody = nil
        connectedHurdle?.connectedHurdleCandy = nil
        connectedHurdle?.healthIndicator.isHidden = true
        self.healthIndicator.isHidden = true
        connectedHurdle?.beginCrashAnimation(withCompletion: nil)
        let bombAnimation = SKAction.animate(with: animationFrames, timePerFrame: 0.08)
        
        let removingAction = SKAction.run { [weak self] in
            self?.removeFromParent()
            completion?()
        }
        
        run(SKAction.sequence([bombAnimation, removingAction]))
    }
}


