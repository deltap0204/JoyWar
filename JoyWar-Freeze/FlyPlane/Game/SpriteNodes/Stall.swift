//
//  IceCreamBucket.swift
//  Game
//
//  Created by Developer on 27.05.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import Foundation

import Foundation
import UIKit
import SpriteKit

class Stall: SKSpriteNode {
    
    
    // MARK: Properties
    private let umbrellaTexture = SKTexture(image: #imageLiteral(resourceName: "Stall_Umbrella"))
    private let stickTexture = SKTexture(image: #imageLiteral(resourceName: "Stall_Stick"))
    private let telegaTexture = SKTexture(image: #imageLiteral(resourceName: "Stall_Telega"))
    private let wheelTexture = SKTexture(image: #imageLiteral(resourceName: "Stall_Wheel"))
    
    
    
    private let umbrellaNode: SKSpriteNode
    private let stickNode: SKSpriteNode
    let telegaNode: SKSpriteNode
    let wheelNode: SKSpriteNode
    
    
    
    
    // MARK: Lifecycle
    
    init() {
        umbrellaNode = SKSpriteNode(texture: umbrellaTexture)
        stickNode = SKSpriteNode(texture: stickTexture)
        telegaNode = SKSpriteNode(texture: telegaTexture)
        wheelNode = SKSpriteNode(texture: wheelTexture)
        
        super.init(texture: nil, color: UIColor.clear, size: telegaTexture.size())
        zPosition = 0
        
        name = "stall"


        addChild(stickNode)
        addChild(telegaNode)
        addChild(wheelNode)
        addChild(umbrellaNode)
        
        
        umbrellaNode.position.x += telegaNode.size.width/3
        umbrellaNode.position.y += telegaNode.size.height + stickNode.size.height - 100
        
        stickNode.position.x += telegaNode.size.width/3
        stickNode.position.y += telegaNode.size.height
        stickNode.size.height += 50
        
        telegaNode.position.x -= 0
        telegaNode.position.y += 5
        
        wheelNode.position.x -= telegaNode.size.width/3
        wheelNode.position.y -= telegaNode.size.height/3 - 25
        
        beginWheelAnimation()
        
        
        
        umbrellaNode.physicsBody = SKPhysicsBody(texture: umbrellaTexture, size: umbrellaTexture.size())
        umbrellaNode.physicsBody!.categoryBitMask = Categories.nonDestroyableHurdle.rawValue
        umbrellaNode.physicsBody!.isDynamic = false
        umbrellaNode.physicsBody!.affectedByGravity = false

        telegaNode.physicsBody = SKPhysicsBody(texture: telegaTexture, size: telegaTexture.size())
        telegaNode.physicsBody!.categoryBitMask = Categories.nonDestroyableHurdle.rawValue
        telegaNode.physicsBody!.isDynamic = false
        telegaNode.physicsBody!.affectedByGravity = false

        wheelNode.physicsBody = SKPhysicsBody(texture: wheelTexture, size: wheelTexture.size())
        wheelNode.physicsBody!.categoryBitMask = Categories.nonDestroyableHurdle.rawValue
        wheelNode.physicsBody!.isDynamic = false
        wheelNode.physicsBody!.affectedByGravity = false

        setScale(0.85)
        self.run(SKAction.playSoundFileNamed("009-0.mp3", waitForCompletion: false))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    func beginWheelAnimation() {
        let rotation = SKAction.rotate(byAngle: CGFloat.pi*2, duration: 2)
        
        wheelNode.run(SKAction.repeatForever(rotation))
    }
    
}
