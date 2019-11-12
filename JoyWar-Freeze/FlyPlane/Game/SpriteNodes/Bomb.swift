//
//  Bomb.swift
//  FlyPlane
//
//  Created by Dexter on 25/07/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Bomb: CrashableNode{

    
    let bomb = SKTexture(image: #imageLiteral(resourceName: "Bomb1"))
    
    
    // MARK: Lifecycle
    
   init() {
        super.init(texture: bomb, color: UIColor(), size: CGSize(width: bomb.size().width/2, height: bomb.size().height/2))
        maxHealth = 100
        zPosition = 1
        name = "bomb"
        everlastingFuseAnimation()
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width/2, height: size.height/2))
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitMask = Categories.hurdle.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Actions
    
    func everlastingFuseAnimation() -> Void {
        
        let fuse1 = SKTexture(image: UIImage(cgImage: #imageLiteral(resourceName: "Bomb1").cgImage!, scale: 0.05, orientation: .up))
        let fuse2 = SKTexture(image: UIImage(cgImage: #imageLiteral(resourceName: "Bomb2").cgImage!, scale: 0.05, orientation: .up))
        let fuse3 = SKTexture(image: UIImage(cgImage: #imageLiteral(resourceName: "Bomb3").cgImage!, scale: 0.05, orientation: .up))
        let fuse4 = SKTexture(image: UIImage(cgImage: #imageLiteral(resourceName: "Bomb2").cgImage!, scale: 0.05, orientation: .up))
        
        let bombFuseAnimation = SKAction.animate(with: [ fuse1, fuse2, fuse3, fuse4 ], timePerFrame: 0.3)
        run(SKAction.repeatForever(bombFuseAnimation))
    }
    
    
    // MARK: Crashable
    
    override func beginCrashAnimation(withCompletion completion: (()->())?) {
        super.beginCrashAnimation(withCompletion: nil)
        self.physicsBody = nil
        beginBurstAnimation(withCompletion: completion)
    }
}


// MARK: Bursting

extension Bomb: Bursting {

    func beginBurstAnimation(withCompletion completion: (()->())?) {
        
        let bomb1 = SKTexture(image: #imageLiteral(resourceName: "Bomb1"))
        let bomb2 = SKTexture(image: #imageLiteral(resourceName: "Bomb2"))
        let bomb3 = SKTexture(image: #imageLiteral(resourceName: "Bomb3"))
        let bomb4 = SKTexture(image: #imageLiteral(resourceName: "Bomb4"))
        let bomb5 = SKTexture(image: #imageLiteral(resourceName: "Bomb5"))
        let bomb6 = SKTexture(image: #imageLiteral(resourceName: "Bomb6"))
        let bomb7 = SKTexture(image: #imageLiteral(resourceName: "Bomb7"))
        let bomb8 = SKTexture(image: #imageLiteral(resourceName: "Bomb8"))
        let bomb9 = SKTexture(image: #imageLiteral(resourceName: "Bomb9"))
        let bomb10 = SKTexture(image: #imageLiteral(resourceName: "Bomb10"))
        let bomb11 = SKTexture(image: #imageLiteral(resourceName: "Bomb11"))
        let bomb12 = SKTexture(image: #imageLiteral(resourceName: "Bomb12"))
        let bomb13 = SKTexture(image: #imageLiteral(resourceName: "Bomb13"))
        let bomb14 = SKTexture(image: #imageLiteral(resourceName: "Bomb14"))
        let bomb15 = SKTexture(image: #imageLiteral(resourceName: "Bomb15"))
        let bomb16 = SKTexture(image: #imageLiteral(resourceName: "Bomb16"))
        let bomb17 = SKTexture(image: #imageLiteral(resourceName: "Bomb17"))
        let bomb18 = SKTexture(image: #imageLiteral(resourceName: "Bomb18"))
        let bomb19 = SKTexture(image: #imageLiteral(resourceName: "Bomb18"))
        let bomb20 = SKTexture(image: #imageLiteral(resourceName: "Bomb18"))
        let bomb21 = SKTexture(image: #imageLiteral(resourceName: "Bomb18"))
        
        let bombAnimation = SKAction.animate(with: [ bomb1, bomb2, bomb3, bomb4, bomb5, bomb6, bomb7, bomb8, bomb9, bomb10, bomb11, bomb12, bomb13, bomb14, bomb15, bomb16, bomb17, bomb18, bomb19, bomb20, bomb21], timePerFrame: 0.025)
        let removingAction = SKAction.run { [weak self] in
            self?.removeFromParent()
            completion?()
        }
        
        run(SKAction.sequence([bombAnimation, removingAction]))
    }

}
