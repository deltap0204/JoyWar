//
//  Plane.swift
//  FlyPlane
//
//  Created by Dexter on 22/04/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

protocol PlaneMachineGunDelegate {
    func updateBullets(count: Int)
    func startReloadCountdown(duration: Double)
}

protocol PlaneRocketGunDelegate {
    func updateRockets(count: Int)
    func startReloadCountdown(duration: Double)
}


class Plane: CrashableNode {
    
    // MARK: Properties
    
    let plane = SKTexture(image: #imageLiteral(resourceName: "fly_01"))
    let bubble = Bubble()
    var isBubbleEnabled: Bool {
        return bubble.parent != nil
    }
    var isBalloonEnabled = false
    
    // MARK: Lifecycle
    
    init() {
        super.init(texture: plane, color: UIColor(), size: CGSize(width: plane.size().width / 5, height: plane.size().height / 5))

        setInitialPhysics()
        zPosition = 1
        maxHealth = 100
        self.name = "plane"
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Actions
    
    func useBubble() {
        guard bubble.parent == nil else {
            return
        }
        
        bubble.zPosition = 0
        bubble.physicsBody = nil
        addChild(bubble)
        bubble.beginExpandAnimation()
        bubble.beginAnimation()
        setBubblePhysics()
        
    }
   
    func removeBubble() {
        
        bubble.removeFromParent()
        setInitialPhysics()
        
    }
    
    func setInitialPhysics() {
    //physicsBody = SKPhysicsBody(circleOfRadius: size.width / 4)

        physicsBody = SKPhysicsBody(texture: plane,
                                                  size: CGSize(width: plane.size().width / 5, height: plane.size().height / 5))
        physicsBody!.isDynamic = true
        physicsBody!.allowsRotation = false
        physicsBody!.affectedByGravity = false
        
        
        physicsBody!.categoryBitMask = Categories.plane.rawValue
        physicsBody!.collisionBitMask = Categories.world.rawValue | Categories.hurdle.rawValue | Categories.nonDestroyableHurdle.rawValue
        physicsBody!.contactTestBitMask = Categories.score.rawValue | Categories.world.rawValue | Categories.hurdle.rawValue | Categories.dollar.rawValue | Categories.candyToDollar.rawValue | Categories.superPower.rawValue | Categories.nonDestroyableHurdle.rawValue
    }
    
    
    
    func setBubblePhysics() {
        
        let bufPhysicsBody = SKPhysicsBody(circleOfRadius: size.width / 4)
        physicsBody = SKPhysicsBody(circleOfRadius: bubble.bubble.size().width/4.5)
        physicsBody!.isDynamic = true
        physicsBody!.allowsRotation = false
        physicsBody!.affectedByGravity = false
        
        physicsBody?.mass = bufPhysicsBody.mass
        
        physicsBody!.categoryBitMask = Categories.superPower.rawValue
        physicsBody!.collisionBitMask = Categories.world.rawValue
        physicsBody!.contactTestBitMask = Categories.score.rawValue | Categories.world.rawValue | Categories.hurdle.rawValue | Categories.dollar.rawValue | Categories.candyToDollar.rawValue | Categories.superPower.rawValue
        
        
    }
    
    func beginAnimation() {
        
        let fly1 = SKTexture(image: #imageLiteral(resourceName: "fly_01"))
        let fly2 = SKTexture(image: #imageLiteral(resourceName: "fly_02"))
        let fly3 = SKTexture(image: #imageLiteral(resourceName: "fly_03"))
        let fly4 = SKTexture(image: #imageLiteral(resourceName: "fly_04"))
        let fly5 = SKTexture(image: #imageLiteral(resourceName: "fly_05"))
        let fly6 = SKTexture(image: #imageLiteral(resourceName: "fly_06"))
        let fly7 = SKTexture(image: #imageLiteral(resourceName: "fly_07"))
        let fly8 = SKTexture(image: #imageLiteral(resourceName: "fly_08"))
        let fly9 = SKTexture(image: #imageLiteral(resourceName: "fly_09"))
        let fly10 = SKTexture(image: #imageLiteral(resourceName: "fly_10"))
        let fly11 = SKTexture(image: #imageLiteral(resourceName: "fly_11"))
        let fly12 = SKTexture(image: #imageLiteral(resourceName: "fly_12"))
        let fly13 = SKTexture(image: #imageLiteral(resourceName: "fly_13"))
        let fly14 = SKTexture(image: #imageLiteral(resourceName: "fly_14"))
        let fly15 = SKTexture(image: #imageLiteral(resourceName: "fly_15"))
        let fly16 = SKTexture(image: #imageLiteral(resourceName: "fly_16"))
        let fly17 = SKTexture(image: #imageLiteral(resourceName: "fly_17"))
        let fly18 = SKTexture(image: #imageLiteral(resourceName: "fly_18"))
        let fly19 = SKTexture(image: #imageLiteral(resourceName: "fly_19"))
        let fly20 = SKTexture(image: #imageLiteral(resourceName: "fly_20"))
        let fly21 = SKTexture(image: #imageLiteral(resourceName: "fly_21"))
        let fly22 = SKTexture(image: #imageLiteral(resourceName: "fly_22"))
        let fly23 = SKTexture(image: #imageLiteral(resourceName: "fly_23"))
        let fly24 = SKTexture(image: #imageLiteral(resourceName: "fly_24"))
        let fly25 = SKTexture(image: #imageLiteral(resourceName: "fly_25"))
        
        let planeFlyingAnimation = SKAction.animate(with: [ fly1, fly2, fly3, fly4, fly5, fly6, fly7, fly8, fly9, fly10, fly11, fly12, fly13, fly14, fly15, fly16, fly17, fly18, fly19, fly20, fly21, fly22, fly23, fly24, fly25 ], timePerFrame: 0.025)
        
        run(SKAction.repeatForever(planeFlyingAnimation))
    
    }
    
    func beginAlphaAnimation(_ isGameScene: Bool) {
        let alphaFull = SKAction.fadeAlpha(to: 1.0, duration: 0.1)
        let alpha3By4 = SKAction.fadeAlpha(to: 0.7, duration: 0.1)
        let alpha1By2 = SKAction.fadeAlpha(to: 0.4, duration: 0.1)
        let alpha1By1 = SKAction.fadeAlpha(to: 0.0, duration: 0.1)
        var alphaSequence = SKAction()
        
        if isGameScene {
            alphaSequence = SKAction.sequence([alpha1By1, alpha1By2, alpha3By4, alphaFull])
        } else {
            alphaSequence = SKAction.sequence([alpha3By4, alpha1By2, alpha1By1])
        }
        
        run(alphaSequence)
    }
    
    func beginStartUpAnimation() {
        run(getPlanePathForAnimation())
    }
    
    func drawCoinAnimationCurvePath(_ coin: SKNode) -> CGPath {
        
        // Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 317.5, y: 396.5))
        bezierPath.addLine(to: CGPoint(x: 343.29, y: 396.5))
        bezierPath.addCurve(to: CGPoint(x: 391.11, y: 396.5), controlPoint1: CGPoint(x: 343.29, y: 396.5), controlPoint2: CGPoint(x: 362.51, y: 462.5))
        bezierPath.addCurve(to: CGPoint(x: 437.53, y: 396.5), controlPoint1: CGPoint(x: 419.72, y: 330.5), controlPoint2: CGPoint(x: 437.53, y: 396.5))
        bezierPath.addCurve(to: CGPoint(x: 490.99, y: 396.5), controlPoint1: CGPoint(x: 437.53, y: 396.5), controlPoint2: CGPoint(x: 460.04, y: 471.5))
        bezierPath.addCurve(to: CGPoint(x: 556.16, y: 396.5), controlPoint1: CGPoint(x: 521.93, y: 321.5), controlPoint2: CGPoint(x: 556.16, y: 396.5))
        bezierPath.addCurve(to: CGPoint(x: 626.49, y: 396.5), controlPoint1: CGPoint(x: 556.16, y: 396.5), controlPoint2: CGPoint(x: 588.05, y: 527.5))
        bezierPath.addCurve(to: CGPoint(x: 679.48, y: 396.5), controlPoint1: CGPoint(x: 664.94, y: 265.5), controlPoint2: CGPoint(x: 679.48, y: 396.5))
        bezierPath.addCurve(to: CGPoint(x: 747.93, y: 396.5), controlPoint1: CGPoint(x: 679.48, y: 396.5), controlPoint2: CGPoint(x: 714.18, y: 490.5))
        bezierPath.addCurve(to: CGPoint(x: 832.8, y: 396.5), controlPoint1: CGPoint(x: 781.69, y: 302.5), controlPoint2: CGPoint(x: 832.8, y: 396.5))
        bezierPath.addLine(to: CGPoint(x: 867.5, y: 396.5))
        UIColor.black.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
        
        return bezierPath.cgPath
    }
    
    func getPlanePathForAnimation() -> SKAction {
        let path = drawCoinAnimationCurvePath(self)
        
        let followPath = SKAction.follow(path, asOffset: false, orientToPath: false, duration: 12.5)
        
        let repeatAnimation = SKAction.repeatForever(followPath)
        
        return repeatAnimation
    }
    
    
    // MARK: Machine Gun
    
    private let bulletsCapacity = PlayersBackpack.bulletsCount//50
    let reloadDuration = 10.0
    let bulletDelay = 0.125
    var machineGunDelegate: PlaneMachineGunDelegate?
    private var isMachineGunActivated = false {
        didSet{
            if isMachineGunActivated {
                shootingBulletChain()
            }
        }
    }
    
    var bulletsCount: Int = PlayersBackpack.bulletsCount {//50 {
        didSet{
            if bulletsCount == 0{
               /* machineGunDelegate?.startReloadCountdown(duration: reloadDuration)
                delay(reloadDuration, closure: {
                    self.bulletsCount = PlayersBackpack.bulletsCount//self.bulletsCapacity
                })*/
            }
        }
    }
    
    private func shootingBulletChain() {
        guard PlayersBackpack.bulletsCount > 0, isMachineGunActivated else { return }
        let bullet = Bullet()
        bullet.position = position
        bullet.beginFlyingAnimation()
        parent?.addChild(bullet)
        var dy = physicsBody?.velocity.dy ?? 0
        dy /= 17
        
        bullet.physicsBody?.applyImpulse(CGVector(dx: 50, dy: dy ))
        bulletsCount -= 1
        self.run(SKAction.playSoundFileNamed("003-0.mp3", waitForCompletion: false))
        machineGunDelegate?.updateBullets(count: bulletsCount)
        if isMachineGunActivated {
            delay(bulletDelay) {
                self.shootingBulletChain()
            }
        }
        delay(5, closure: {
            bullet.removeFromParent()
        })
    }
    
    func enableMachineGun() {
        isMachineGunActivated = true
    }
    
    func disableMachineGun() {
        isMachineGunActivated = false
    }
    
    
    // MARK: Rockets
    
    private let reloadRocketDuration = 10.0
    var rocketDelegate: PlaneRocketGunDelegate?
    static var currentRocketType = RocketType.type1

    func shootRocket() {
        guard PlayersBackpack.rocketsCount [Plane.currentRocketType]! > 0 else { return }
        
        let rocket = Rocket(Plane.currentRocketType)
        rocket.position = position
        rocket.beginDropAnimation()
        
        switch Plane.currentRocketType{
            
        case .type1: rocket.run(SKAction.scale(to: 1.2*1.5, duration: Double(rocket.type.dropCount())*0.09))
        case .type5: break
        default: rocket.run(SKAction.scale(to: 1.3, duration: Double(rocket.type.dropCount())*0.09))
            
        }
        
       /* if self.currentRocketType != .type5 && self.currentRocketType != .type1{
            rocket.run(SKAction.scale(to: 1.3, duration: Double(rocket.type.dropCount())*0.09))
        }
        else if self.currentRocketType == .type1 {
            rocket.run(SKAction.scale(to: 1.5*1.5, duration: Double(rocket.type.dropCount())*0.09))
        }
        else if self.currentRocketType == .type1 {}*/
        
        self.rocketDelegate?.startReloadCountdown(duration: self.reloadRocketDuration)
        self.parent?.addChild(rocket)
        
        var dy = self.physicsBody?.velocity.dy ?? 0
        dy /= 17
        var rocketRevealAnimation = SKAction()
        if Plane.currentRocketType != .type5{
            rocketRevealAnimation = SKAction.moveBy(x: 0, y: -70, duration: 0.6)
        }
        else {
            rocketRevealAnimation = SKAction.moveBy(x: 0, y: -70, duration: 0.25)
        }
        let rocketStartupAnimation = SKAction.applyImpulse(CGVector(dx: 30 / rocket.type.rocketStartupAnimationDuration(), dy: 0), duration: rocket.type.rocketStartupAnimationDuration())
        let rocketFlyingAnimation = SKAction.run {
            rocket.physicsBody?.velocity=CGVector(dx: 10, dy: 0)
            
        }
        
        rocket.physicsBody?.linearDamping = 0
        PlayersBackpack.rocketsCount [Plane.currentRocketType]! -= 1
        self.rocketDelegate?.updateRockets(count: PlayersBackpack.rocketsCount[Plane.currentRocketType]!)
       
            rocket.run(SKAction.sequence([rocketRevealAnimation]))
        

        
        delay(Double(rocket.type.dropCount())*0.12, closure: {
            if rocket.physicsBody!.isDynamic{
            rocket.setScale(1)
                rocket.physicsBody?.mass = 0.1
                
                
            switch Plane.currentRocketType{
                
            case .type1: self.run(SKAction.playSoundFileNamed("005-0.mp3", waitForCompletion: false))
            case .type2: self.run(SKAction.playSoundFileNamed("005-1.mp3", waitForCompletion: false))
            case .type3: self.run(SKAction.playSoundFileNamed("005-2.mp3", waitForCompletion: false))
            case .type4: self.run(SKAction.playSoundFileNamed("005-3.mp3", waitForCompletion: false))
            case .type5: self.run(SKAction.playSoundFileNamed("005-4.mp3", waitForCompletion: false))
                
            }
            
                
            rocket.run(SKAction.sequence([rocketStartupAnimation, rocketFlyingAnimation]))
           
            rocket.beginFlyingAnimation()
            
            
            delay(20, closure: {
                rocket.removeFromParent()
            })
            }
        })
    }
}


// MARK: Bursting

extension Plane : Bursting {
    
    func beginBurstAnimation(withCompletion completion: (()->())?) {
        
        let explosion1 = SKTexture(image: #imageLiteral(resourceName: "Explosion1"))
        let explosion2 = SKTexture(image: #imageLiteral(resourceName: "Explosion2"))
        let explosion3 = SKTexture(image: #imageLiteral(resourceName: "Explosion3"))
        let explosion4 = SKTexture(image: #imageLiteral(resourceName: "Explosion4"))
        let explosion5 = SKTexture(image: #imageLiteral(resourceName: "Explosion5"))
        let explosion6 = SKTexture(image: #imageLiteral(resourceName: "Explosion6"))
        let explosion7 = SKTexture(image: #imageLiteral(resourceName: "Explosion7"))
        let explosion8 = SKTexture(image: #imageLiteral(resourceName: "Explosion8"))
        let explosion9 = SKTexture(image: #imageLiteral(resourceName: "Explosion9"))
        let explosion10 = SKTexture(image: #imageLiteral(resourceName: "Explosion10"))
        
        let bombAnimation = SKAction.animate(with: [ explosion1, explosion2, explosion3, explosion4, explosion5, explosion6, explosion7, explosion8, explosion9, explosion10], timePerFrame: 0.03)
        let removingAction = SKAction.run { [weak self] in
            self?.removeFromParent()
            completion?()
        }
        
        run(SKAction.sequence([bombAnimation, removingAction]))
    }
}
