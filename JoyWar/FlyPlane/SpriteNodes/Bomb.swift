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

class Bomb: SKSpriteNode {
    let bomb = SKTexture(imageNamed: "BombPurple")
    
    init() {
        super.init(texture: bomb, color: UIColor(), size: CGSize(width: bomb.size().width / 2.85, height: bomb.size().height / 2.85))
        zPosition = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func everlastingFuseAnimation() -> Void {
        let fuse1 = SKTexture(imageNamed: "Fuse1")
        let fuse2 = SKTexture(imageNamed: "Fuse2")
        
        let bombFuseAnimation = SKAction.animateWithTextures([ fuse1, fuse2 ], timePerFrame: 1.0)
        
        runAction(SKAction.repeatActionForever(bombFuseAnimation))
    }
}