//
//  JoyStick.swift
//  FlyPlane
//
//  Created by Dexter on 25/07/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class JoyStick: CrashableNode, Cashable {
    
    
    // MARK: Properties
    
    let joyStick = SKTexture(image: #imageLiteral(resourceName: "CandyStick1"))
    var price: hurdleCandyPricing = .joyStick
    
    // MARK: Lifecycle
    
    init() {
        super.init(texture: joyStick,
                   color: UIColor(),
                   size: CGSize(width: joyStick.size().width,
                                height: joyStick.size().height))
        maxHealth = 100
        zPosition = 0
        
        name = "joyStick"
        physicsBody = SKPhysicsBody(texture: joyStick, size: size)
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitMask = Categories.hurdle.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Crashable
    
    override func beginCrashAnimation(withCompletion completion: (()->())?) {
        super.beginCrashAnimation(withCompletion: nil)
        var crashAnimationFrames = [SKTexture]()
        var nameBase = "CandyStick"
        for i in 1...14 {
            crashAnimationFrames.append(SKTexture(imageNamed: "\(nameBase)\(i)"))
        }
        let crashAnimation = SKAction.animate(with: crashAnimationFrames, timePerFrame: 0.05)
        self.run(SKAction.playSoundFileNamed("004-2.mp3", waitForCompletion: false))
        run(SKAction.sequence([crashAnimation]))
    }
}

