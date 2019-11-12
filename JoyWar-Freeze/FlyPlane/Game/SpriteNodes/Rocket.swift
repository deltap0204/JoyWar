//
//  RocketType3.swift
//  Game
//
//  Created by Developer on 21.04.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import UIKit
import SpriteKit

enum RocketType: String{
    case type1 = "RocketType1"
    case type2 = "RocketType2"
    case type3 = "RocketType3"
    case type4 = "RocketType4"
    case type5 = "RocketType5"
    
    
    func getIndicatorImage() -> UIImage {
        let indicatorImages: [UIImage] = [#imageLiteral(resourceName: "IconType1"), #imageLiteral(resourceName: "IconType2"), #imageLiteral(resourceName: "IconType3"), #imageLiteral(resourceName: "IconType4"), #imageLiteral(resourceName: "IconType5")]
        return indicatorImages[self.getNumberOfType() - 1]
    }
    func getImage() -> UIImage {
        switch self {
        case .type1:
            return #imageLiteral(resourceName: "Type1")
        case .type2:
            return #imageLiteral(resourceName: "Type2")
        case .type3:
            return #imageLiteral(resourceName: "Type3")
        case .type4:
            return #imageLiteral(resourceName: "Type4")
        case .type5:
            return #imageLiteral(resourceName: "Type5")
        }
    }
    func getFlameImage() -> UIImage{
        switch self {
        case .type1:
            return #imageLiteral(resourceName: "Glow_1_0")
        case .type2:
            return #imageLiteral(resourceName: "Glow_2_0")
        case .type3:
            return #imageLiteral(resourceName: "Glow_3_0")
        case .type4:
            return #imageLiteral(resourceName: "Glow_4_0")
        case .type5:
            return #imageLiteral(resourceName: "Glow_5_0")
        }
    
    }
    func getNumberOfType()->Int{
            switch self {
            case .type1:
                return 1
            case .type2:
                return 2
            case .type3:
                return 3
            case .type4:
                return 4
            case .type5:
                return 5
            }
    }
    func getBurstingAnimation() -> [SKTexture] {
        var values: [SKTexture] = []
        for i in 0...15 {
            values.append(SKTexture(imageNamed: "RocketBurst\(i)"))
        }
        return values
    }
    func getFlyingAnimation() -> [SKTexture] {
        var values: [SKTexture] = []
        
        for i in 0...frameCount() {
            values.append(SKTexture(imageNamed: "Roket_\(getNumberOfType())_\(i)"))
        }
        return values
    }
    func getImageForStore() -> [UIImage] {
        var values: [UIImage] = []
        
        for i in 0...storeFrameCount() {
            values.append(UIImage(imageLiteralResourceName: "RoketS_\(getNumberOfType())_\(i)"))
        }
        return values
    }
    func getFlameAnimation() -> [SKTexture] {
        var values: [SKTexture] = []
        if self != .type2 {
        for i in 0...fireFrameCount() {
            values.append(SKTexture(imageNamed: "Glow_\(getNumberOfType())_\(i)"))
            }
        }
        else{
            for i in 0...RocketType.type1.fireFrameCount() {
                values.append(SKTexture(imageNamed: "Glow_\(RocketType.type1.getNumberOfType())_\(i)"))
            }

        }
        return values
    }
    
    
    func getDropAnimation() -> [SKTexture] {
        var values: [SKTexture] = []
        
        for i in 0...dropCount() {
            values.append(SKTexture(imageNamed: "R\(getNumberOfType())Drop_\(i)"))
        }
        return values
    
    }
    
    func getHealth() -> CGFloat {
        
        switch self {
        case .type1:
            return 1
        case .type2:
            return 2
        case .type3:
            return 2
        case .type4:
            return 4
        case .type5:
            return 5
        }
    }
    
    func frameCount() -> Int {
        switch self {
        case .type1:
            return 9
        case .type2:
            return 9
        case .type3:
            return 9
        case .type4:
            return 9
        case .type5:
            return 2
        }
        
    }
    func fireFrameCount() -> Int {
        switch self {
        case .type1:
            return 9
        case .type2:
            return 9
        case .type3:
            return 8
        case .type4:
            return 7
        case .type5:
            return 7
        }
        
    }
    
    func dropCount() -> Int {
        switch self {
        case .type1:
            return 8
        case .type2:
            return 7
        case .type3:
            return 6
        case .type4:
            return 8
        case .type5:
            return 7
        }
    
    }
    
    func storeFrameCount() -> Int{
        switch self {
        case .type1:
            return 9
        case .type2:
            return 9
        case .type3:
            return 8
        case .type4:
            return 9
        case .type5:
            return 8
        }
    
    }
    
    func getNext() -> RocketType {
        
        switch self {
        case .type1:
            return .type2
        case .type2:
            return .type3
        case .type3:
            return .type4
        case .type4:
            return .type5
        case .type5:
            return .type1
        }
    }
    func getSize() -> CGSize {
        
        switch self {
        case .type1:
            return CGSize(width: 78*1.3, height: 21*1.3)
            
        case .type2:
            return CGSize(width: 77*1.3, height: 20*1.3)
            
        case .type3:
            return CGSize(width: 78*1.3, height: 21*1.3)
            
        case .type4:
            return CGSize(width: 77*1.3, height: 20*1.3)
            
        case .type5:
            return CGSize(width: 78, height: 43)
        }
    }
    func getDropSize() -> CGSize {
        
        switch self {
        case .type1:
            return CGSize(width: 78*1.4/2.64*2.17/1.5, height: 21*1.5/1.5)
            
        case .type2:
            return CGSize(width: 77/3.77*4.03*1.1, height: 20*1.1)
            
        case .type3:
            return CGSize(width: 78*2/3.69*2.56, height: 21*1.6)
            
        case .type4:
            return CGSize(width: 77*3/3.93*1.36, height: 20*3)
            
        case .type5:
            return CGSize(width: 78*1.1/1.81*2.26, height: 43*1.1)
        }
    }

    
    func getFlameSize() -> CGSize {
        
        switch self {
        case .type1:
            return CGSize(width: 67*1.3, height: 35*1.3)
            
        case .type2:
            return CGSize(width: 81*1.3, height: 41*1.3)
        case .type3:
            return CGSize(width: 49*1.3, height: 46*1.3)
            
        case .type4:
            return CGSize(width: 88*1.3, height: 40*1.3)
            
        case .type5:
            return CGSize(width: 85, height: 45)
        }
    }
    
    func rocketStartupAnimationDuration()->Double{
        switch self {
        case .type1:
            return 0.2
            
        case .type2:
            return 0.4
            
        case .type3:
            return 1.0
            
        case .type4:
            return 2.0
            
        case .type5:
            return 7.0
        }
    
    
    }
    func rocketMass()->CGFloat{
        switch self {
            
        case .type1:
            return 0.5
            
        case .type2:
            return 1.0
            
        case .type3:
            return 1.5
            
        case .type4:
            return  2.0
            
        case .type5:
            return 5.0
        }
    
    }


    
}

class Rocket: Ammo {
    
    // MARK: Properties
    
    override var damage: CGFloat { return 100 }
    
    override var health: CGFloat  {
        didSet{
            if health == 2 && self.type == .type4 {
                DispatchQueue.global(qos: .userInteractive).async {
                    self.flyToNextHurdle()
                }
            }
            if health == 1  {
                physicsBody?.collisionBitMask = Categories.hurdle.rawValue
                if self.type == .type3 {
                    DispatchQueue.global(qos: .userInteractive).async {
                        self.flyToNextHurdle()
                    }
                }
            }
            if health <= 0 {
                self.beginBurstAnimation(withCompletion: nil)
            }
        }
    }
    
    let type: RocketType
    
    
    // MARK: Lifecycle
    
    init(_ type: RocketType) {
        self.type = type
        let texture = SKTexture(image: type.getImage())
        let size: CGSize = type.getSize()
        
        super.init(texture: texture, color: .brown, size: size)
        physicsBody?.affectedByGravity = false
        health = type.getHealth()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Actions
    
    func flyToNextHurdle() {
        
        var nearestHurdle: SKNode?
        while nearestHurdle == nil {
            nearestHurdle = self.findNearestHurdle()
        }
        
        DispatchQueue.main.async {
            //print("--->>>" + (nearestHurdle!.name ?? ""))
            //print("--->>>" + "\(nearestHurdle!.position)")
            //print("--->>>" + "\(nearestHurdle!.positionInScene)")
            //print("--->>>" + "\(self.position)")
            
            
            self.run(SKAction.moveTo(y: nearestHurdle!.positionInScene!.y, duration: 0.3))
        }
        
    }
    
    private func findNearestHurdle() -> SKNode? {
        guard let gameScene = scene as? GameScene else {
            return nil
        }
        var result: SKNode?
        var searchPoint = CGPoint(x: position.x + 150, y: 50)
        while searchPoint.y < gameScene.frame.maxY - 50 {
            var node: SKNode?
            DispatchQueue.main.sync {
                node = gameScene.atPoint(searchPoint)
            }
            if node?.physicsBody?.categoryBitMask == Categories.hurdle.rawValue{
                result = node
                break
            }
            searchPoint.y += 10
        }
        return result
    }
    func beginDropAnimation(){
        let textures = type.getDropAnimation()
        let textureInitialSize = type.getSize()

        size = CGSize(width: type.getDropSize().width, height: type.getDropSize().height)
       
        physicsBody?.contactTestBitMask = 0
        physicsBody?.collisionBitMask = 0
        physicsBody?.categoryBitMask = 0
        
        
        self.run(SKAction.playSoundFileNamed("006-2.mp3", waitForCompletion: false))
        let rocketDropAnimation = SKAction.animate(with: textures, timePerFrame: 0.12)
        let restoringPhysicsBody = SKAction.run {
            self.physicsBody?.contactTestBitMask = Categories.hurdle.rawValue
            self.physicsBody?.collisionBitMask = Categories.world.rawValue
            self.physicsBody?.categoryBitMask = Categories.ammo.rawValue
        }
        run(SKAction.sequence([rocketDropAnimation, restoringPhysicsBody]))
    }
    
    override func beginFlyingAnimation() {
        
       let textures = type.getFlyingAnimation()
        let textureInitialSize = type.getSize()//textures[0].size()
        size = CGSize(width: textureInitialSize.width, height: textureInitialSize.height)
       // let flameSize = CGSize(width: type.getSize().width/78*65, height: type.getSize().height/78*65)
        let rocketFlyingAnimation = SKAction.animate(with: textures, timePerFrame: 0.1)
    
            run(SKAction.repeatForever(rocketFlyingAnimation))
        //if(type.getNumberOfType() == 1){
            let flameTexture = SKTexture(image: type.getImage())
            let flameNode = SKSpriteNode(texture: flameTexture, color: UIColor(), size: type.getFlameSize())
            flameNode.position = CGPoint(x: 0-size.width/2-flameNode.size.width/2+5, y: 0)
            flameNode.zPosition = 0
            addChild(flameNode)
            let flameTextures = type.getFlameAnimation()
            let flameAnimation = SKAction.animate(with: flameTextures, timePerFrame: 0.1)
            flameNode.run(SKAction.repeatForever(flameAnimation))
            
            //}

    }
    
    
    // MARK: Bursting
    
    override func beginBurstAnimation(withCompletion completion: (()->())?) {
        self.removeAllActions()
        self.removeAllChildren()
        super.beginBurstAnimation(withCompletion: nil)
        
        var textures = type.getBurstingAnimation()
        let textureInitialSize = textures[0].size()
        texture = textures[0]
        size = CGSize(width: textureInitialSize.width/3/1.5, height: textureInitialSize.height/3/1.5)
        physicsBody?.isDynamic = false
        physicsBody!.affectedByGravity = true
        zPosition = 3
        
        let burstAnimation = SKAction.animate(with: textures, timePerFrame: 1/16)
        let moveAnimation = SKAction.moveBy(x: -150, y: 0, duration: 3)
        let animation =
            SKAction.group([
            SKAction.sequence([burstAnimation,
                              SKAction.fadeAlpha(to: 0.0, duration: 1)]),
            moveAnimation
                ])
        let removingAction = SKAction.run {
            completion?()
            
            self.removeFromParent()
        }
        
        run(SKAction.sequence([animation, SKAction.fadeAlpha(to: 0.0, duration: 1), removingAction]))
    }
}



