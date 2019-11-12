//
//  IceStick.swift
//  FlyPlane
//
//  Created by Dexter on 25/07/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class IceStick: CrashableNode, Cashable {
    
    
    // MARK: Properties
    var price: hurdleCandyPricing = .iceStick
    let iceStick = SKTexture(image: #imageLiteral(resourceName: "IceCream0"))

    
    // MARK: Lifecycle
    
    init() {
        super.init(texture: iceStick, color: UIColor(), size: CGSize(width: iceStick.size().width / 2,
                                                                     height: iceStick.size().height / 2))
        maxHealth = 100
        zPosition = 0
        
        name = "iceStick"
        
        physicsBody = SKPhysicsBody(texture: iceStick, size: size)
        physicsBody!.isDynamic = false
        physicsBody!.categoryBitMask = Categories.hurdle.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Crashable
    
    override func beginCrashAnimation(withCompletion completion: (()->())?) {
        super.beginCrashAnimation(withCompletion: nil)
        
        var crashAnimationFrames = [SKTexture]()
        var nameBase = "IceCream"
        for i in 0...15 {
            crashAnimationFrames.append(SKTexture(imageNamed: "\(nameBase)\(i)"))
        }
        let crashAnimation = SKAction.animate(with: crashAnimationFrames, timePerFrame: 0.05)
        run(crashAnimation)
        run(SKAction.playSoundFileNamed("004-1.mp3", waitForCompletion: false))
        physicsBody = nil
    }
}


