//
//  Enemy.swift
//  Game
//
//  Created by Developer on 27.04.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import UIKit
import SpriteKit

class Enemy: CrashableNode {
    
    enum EnemyAnimationType: String {
        case bear = "Bear"
        case iceCreamMan = "icecreamman"
        
        enum AnimationState: String {
            case appearing = "A"
            case flying = "F"
            case dying = "D"
            
            
            var numberOfFrames: Int {
                switch self {
                case .appearing: return 30
                case .flying: return 30
                case .dying: return 22
                }
            }
        }
        func getAnimationFrames(of state: AnimationState) -> [SKTexture] {
            var frames = [SKTexture]()
            for i in 0..<state.numberOfFrames {
                let imageName = self.rawValue + state.rawValue + "\(i)"
                let frame = SKTexture(imageNamed: imageName)
                //print(imageName)
                frames.append(frame)
            }
            return frames
        }
    
    }
    
    // MARK: Properties
    var type: EnemyAnimationType
    static var isShown = false
    
    
    // MARK: Lifecycle
    
    init() {
        
        
        let enemyTypeRandomizer = Int.random(range: 1...100)
        
        if enemyTypeRandomizer % 2 == 0 {
            self.type = .bear
        } else {
            self.type = .iceCreamMan
        }
        
        let texture = type.getAnimationFrames(of: .appearing)[0]
        
        super.init(texture: texture,
                   color: UIColor(),
                   size: CGSize(width: texture.size().width/4,
                                height: texture.size().height/4))
        maxHealth = 100
        zPosition = 0
        Enemy.isShown = true
        name = "enemy"
        
        physicsBody = SKPhysicsBody(texture: texture, size: CGSize(width: self.size.width*0.9, height: self.size.height*0.9))
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitMask = Categories.hurdle.rawValue
        physicsBody?.collisionBitMask = 0
        physicsBody?.contactTestBitMask = 0
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func leaveScene(){
        removeFromParent()
        Enemy.isShown = false
        disableMachineGun()
    }
    
    
    // MARK: Machine Gun
    
    private let bulletsCapacity = 20
    let reloadDuration = 2.0
    let bulletDelay = 0.25
    private var isMachineGunActivated = false {
        didSet {
            if isMachineGunActivated {
                shootingBulletChain()
            }
        }
    }
    
    var bulletsCount: Int = 20 {
        didSet {
            if bulletsCount == 0 { delay(reloadDuration) { self.bulletsCount = self.bulletsCapacity; self.shootingBulletChain() } }
        }
    }
    
    private func shootingBulletChain() {
        guard bulletsCount > 0, isMachineGunActivated else { return }
        
        let bullet = Bullet()
        bullet.position = position
        bullet.position.x -= 60
        bullet.position.y += 5
        bullet.physicsBody?.categoryBitMask = Categories.enemyAmmo.rawValue
        bullet.physicsBody?.collisionBitMask = Categories.plane.rawValue | Categories.superPower.rawValue
        bullet.physicsBody?.contactTestBitMask = Categories.plane.rawValue | Categories.superPower.rawValue
        bullet.beginFlyingAnimation()
        bullet.reverse()
        parent?.addChild(bullet)
        bullet.physicsBody?.applyImpulse(CGVector(dx: -75, dy: 0 ))
        bulletsCount -= 1
        
        self.run(SKAction.playSoundFileNamed("003-0.mp3", waitForCompletion: false))
        if isMachineGunActivated { delay(bulletDelay) { self.shootingBulletChain() } }
        
        delay(5) { bullet.removeFromParent() }
    }
    
    func enableMachineGun() { isMachineGunActivated = true }
    
    func disableMachineGun() { isMachineGunActivated = false }
    
    
    // MARK: Crashable

    func beginAnimation() {
        let appearinAnimationFrames = self.type.getAnimationFrames(of: .appearing)
        let appearingAnimation = SKAction.animate(with: appearinAnimationFrames, timePerFrame: 0.1)
        let flyingAnimationFrames = self.type.getAnimationFrames(of: .flying)
        let flyingAnimation = SKAction.animate(with: flyingAnimationFrames, timePerFrame: 0.1)
        
        self.texture = appearinAnimationFrames[0]
        let animationsSequence = SKAction.sequence([appearingAnimation, SKAction.run { self.enableMachineGun() }, SKAction.repeatForever(flyingAnimation)])
        run(animationsSequence)
        
    }
    
    private var isAlreadyResized = false
    override func beginCrashAnimation(withCompletion completion: (()->())?) {
        super.beginCrashAnimation(withCompletion: nil)

        super.removeAllActions()
        
        physicsBody = nil
        
        let crashAnimationFrames = self.type.getAnimationFrames(of: .dying)
        let crashAnimation = SKAction.animate(with: crashAnimationFrames, timePerFrame: 0.09)
        
        self.texture = crashAnimationFrames[0]
        if !isAlreadyResized {
            isAlreadyResized = true
            if self.type == .bear {
                self.size = CGSize(width: self.size.width*1.5, height: self.size.height*1.5)
                //print("RESIZING")
            } else if self.type == .iceCreamMan {
                self.size = CGSize(width: self.size.width*1.5, height: self.size.height*1.5)
            }
        }
        
        let leaving = SKAction.run {
            self.leaveScene()
        }
        self.run(SKAction.playSoundFileNamed("007-1.mp3", waitForCompletion: false))
        run(SKAction.sequence([SKAction.run{ self.disableMachineGun() }, crashAnimation, leaving]))
        
    }
    
    func stop(){
     speed = 0
     isMachineGunActivated = false
    
    }
    
    func resume(){
     speed = 1
     isMachineGunActivated = true
    }
    
}
