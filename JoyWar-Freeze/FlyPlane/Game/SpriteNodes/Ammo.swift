//
//  Ammo.swift
//  Game
//
//  Created by Developer on 24.04.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//
import Foundation
import SpriteKit

class Ammo: SKSpriteNode, Shootable, Bursting, Damagable {

    // MARK: Properties
    
    var damage: CGFloat { return 20 }
    var health: CGFloat = 0 {
        didSet{
            if health == 1 {
                physicsBody?.collisionBitMask = Categories.hurdle.rawValue
            }
            if health <= 0 {
                self.beginBurstAnimation(withCompletion: nil)
            }
        }
    }
    
    // MARK: Lifecycle
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        if self is Bullet{
           physicsBody = SKPhysicsBody(rectangleOf: size)
        }
        else{
            physicsBody = SKPhysicsBody(texture: texture!, size: size)}
        physicsBody?.contactTestBitMask = Categories.hurdle.rawValue
        physicsBody?.collisionBitMask = Categories.world.rawValue
        physicsBody?.categoryBitMask = Categories.ammo.rawValue
        physicsBody?.collisionBitMask = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Actions
    
    func beginFlyingAnimation() {
        
    }
    
    func beginBurstAnimation(withCompletion completion: (() -> ())?) {
        physicsBody?.affectedByGravity = true
    }

}
