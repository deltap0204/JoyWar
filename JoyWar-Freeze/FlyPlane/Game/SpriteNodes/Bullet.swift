//
//  Bullet.swift
//  Game
//
//  Created by Daniel Slupskiy on 15.04.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import Foundation
import SpriteKit

class Bullet: Ammo {
    
    // MARK: Properties
    
    override var damage: CGFloat { return 20 }
   
    
    func getFlyingAnimation() -> [SKTexture] {
        var values: [SKTexture] = []
        
        for i in 1...3 {
            values.append(SKTexture(imageNamed: "Bullet0\(i)"))
        }
        return values
    }

    // MARK: Lifecycle
    
    override func beginFlyingAnimation() {
        
        let textures = self.getFlyingAnimation()
        let textureInitialSize =  CGSize(width: 44, height: 11)
        size = CGSize(width: textureInitialSize.width, height: textureInitialSize.height)
        
        let bulletFlyingAnimation = SKAction.animate(with: textures, timePerFrame: 0.1)
        
        run(SKAction.repeatForever(bulletFlyingAnimation))
    }
    
    init() {
    
        let texture = SKTexture(image: #imageLiteral(resourceName: "Bullet01")) //#imageLiteral(resourceName: "Bomb1"))
       super.init(texture: texture, color: .brown, size: CGSize(width:50, height:12.5))
        health = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reverse(){
    self.xScale = -1
    }
}
