//
//  Donuts.swift
//  Game
//
//  Created by Developer on 11.07.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import UIKit
import SpriteKit

class Donuts: CrashableNode{
    
    static let donutsArray : Array = [#imageLiteral(resourceName: "Donut1"), #imageLiteral(resourceName: "Donut2"), #imageLiteral(resourceName: "Donut3"), #imageLiteral(resourceName: "Donut4"), #imageLiteral(resourceName: "Donut5"), #imageLiteral(resourceName: "Donut6"), #imageLiteral(resourceName: "Donut7"), #imageLiteral(resourceName: "Donut8"), #imageLiteral(resourceName: "Donut9")]
    var particles: SKEmitterNode!
    
    // MARK: Lifecycle
    
    init() {
        let donuts = SKTexture(image: Donuts.donutsArray[Int(arc4random_uniform(UInt32(Donuts.donutsArray.count)))])
        super.init(texture: donuts, color: UIColor(), size: CGSize(width: donuts.size().width/12, height: donuts.size().height/12))
        maxHealth = 10
        zPosition = 1
        name = "donuts"
      //  everlastingFuseAnimation()
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width, height: size.height))
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitMask = Categories.hurdle.rawValue
        
        let particlesFilePath = Bundle.main.path(forResource: "DonutParticle", ofType: "sks")
        particles = NSKeyedUnarchiver.unarchiveObject(withFile: particlesFilePath!) as! SKEmitterNode
        particles.setScale(0.23)
        addChild(particles)
        
        //beginExpandAnimation()
        beginAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func beginCrashAnimation(withCompletion completion: (()->())?) {
        super.beginCrashAnimation(withCompletion: nil)
        self.physicsBody = nil
        beginBurstAnimation(withCompletion: completion)
    }
    
    func beginAnimation() {
        let sizeShrink = SKAction.scale(to: 2.0, duration: 0.2)
        let sizeExpand = SKAction.scale(to: 2.3, duration: 0.2)
        let sizeVarientSequence = SKAction.sequence([sizeShrink, sizeExpand])
        run(SKAction.repeatForever(sizeVarientSequence))
    }
}


// MARK: Bursting

extension Donuts: Bursting {
    
    func beginBurstAnimation(withCompletion completion: (()->())?) {
        
        particles.removeFromParent()
        
        var explosionStart: [SKTexture] = []
        var explosionEnd: [SKTexture] = []
        
        for i in 0...3 {
            explosionStart.append(SKTexture(imageNamed: "Poof\(i)"))
        }
        for i in 4...7 {
            explosionEnd.append(SKTexture(imageNamed: "Poof\(i)"))
        }
        let frameDuration = 0.065
        let bombStartAnimation = SKAction.animate(with: explosionStart, timePerFrame: frameDuration)
        let bombEndAnimation = SKAction.animate(with: explosionEnd, timePerFrame: frameDuration)
        let bombDissapearingAnimation = SKAction.fadeOut(withDuration: frameDuration*Double(explosionEnd.count))
        let removingAction = SKAction.run { [weak self] in
            self?.removeFromParent()
            completion?()
        }

        texture = explosionStart[0]
        size = CGSize(width: size.width*3.0, height: size.height*3.0)
        
        run(SKAction.sequence([bombStartAnimation, SKAction.group([bombEndAnimation, bombDissapearingAnimation]), removingAction]))
        delay(0.1, closure: {
            self.setScale(7)
            
        })
        
    }
    
}

