//
//  SKPhysicsDelegate.swift
//  Game
//
//  Created by Daniel Slupskiy on 31.03.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import Foundation
import SpriteKit


// MARK: SKPhysicsContactDelegate

extension GameScene: SKPhysicsContactDelegate {
    
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        if animatingNode.speed > 0 {
            //print("\(contact.bodyA.categoryBitMask) \(contact.bodyB.categoryBitMask)")
            let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
            
            switch(contactMask) {
                
            case Categories.superPower.rawValue | Categories.score.rawValue:
                fallthrough
            case Categories.plane.rawValue | Categories.score.rawValue:
                if !planeTouchScore {
                    planeTouchScore = true
                if contact.bodyA.node?.name != "additionalScore" && contact.bodyB.node?.name != "additionalScore"{
                    self.updateScore() }
                if(plane.isBubbleEnabled){
                    baloon.moveTo(yPoint: queueOfPathForBaloon.dequeue())
                    if contact.bodyA.node is Plane {
                        contact.bodyB.node?.physicsBody = nil
                   
                    
                    } else {
                        contact.bodyB.node?.physicsBody?.allowsRotation = true
                        contact.bodyA.node?.physicsBody = nil
                  
                    }
                    
                    }
                    delay(0.5, closure:  {
                        self.planeTouchScore = false
                    })
                }
                break
            case Categories.superPower.rawValue | Categories.superPower.rawValue:
                fallthrough
            case Categories.plane.rawValue | Categories.superPower.rawValue:
                if !planeTouchSuperPower {
                    planeTouchSuperPower = true
                var contactBody: SKNode?
                if contact.bodyA.node is Plane {
                    contactBody = contact.bodyB.node
                } else {
                    contactBody = contact.bodyA.node
                }
                let basePower = contactBody as! BaseSuperPower
                contactBody = nil
                collect(basePower: basePower)
                    basePower.collectAnimation?()
                }
                delay(0.5, closure:  {
                    self.planeTouchSuperPower = false
                })
                
                break
                
            case Categories.superPower.rawValue | Categories.hurdle.rawValue:
                
                var contactBody: SKNode?
                if contact.bodyA.node is Plane {
                    contactBody = contact.bodyB.node
                } else {
                    contactBody = contact.bodyA.node
                }
                
                guard contactBody is Crashable else { return }
                contactBody?.physicsBody = nil
                guard let crashableObject = contactBody as? Crashable else { return }
                crashableObject.beginCrashAnimation(withCompletion: nil)
                //print("Begin crash animation")
                break
            
            case Categories.superPower.rawValue | Categories.world.rawValue:
                //fallthrough
                plane.run(SKAction.moveTo(y: size.height / 2, duration: 1))
            case Categories.plane.rawValue | Categories.world.rawValue:
                pauseGame()
                //getScoreFromGameData()
                updateHighScoreToGameData(GameScore)
                break
                
            case Categories.plane.rawValue | Categories.enemyAmmo.rawValue:
                guard !plane.isBalloonEnabled else { return }
                
                var ammo: Ammo?
                if !planeTouchBullet{
                    planeTouchBullet = true
                if contact.bodyA.node is Ammo {
                    ammo = contact.bodyA.node as! Ammo
                } else {
                    ammo = contact.bodyB.node as! Ammo
                }
                
                plane.health -= ammo!.damage
                
                if plane.health <= 0 {
                    self.additionalAnimatingNode.speed = 0
                    self.removeAllActions()
                    plane.beginBurstAnimation(withCompletion: { [weak self] in
                        self?.pauseGame()
                    })
                }
                    delay(0.1, closure:  {
                        self.planeTouchBullet = false
                    })

                }
                break
            case Categories.plane.rawValue | Categories.nonDestroyableHurdle.rawValue:
                fallthrough
            case Categories.plane.rawValue | Categories.hurdle.rawValue:
               var contactBody: SKNode?
                if contact.bodyA.node is Plane {
                    contactBody = contact.bodyB.node
                } else {
                    contactBody = contact.bodyA.node
                }
               if contactBody?.name == "iceCream" {
                plane.physicsBody?.contactTestBitMask = Categories.world.rawValue
                bumpFromHurdle()
               }
               else{
                plane.physicsBody!.affectedByGravity = true
                animatingNode.speed = 0
                if let burstingBody = contactBody as? Bursting {
                    
                    (burstingBody as! SKNode).removeFromParent()

                    delay(0.1, closure: {
                        self.removeAllActions()
                        self.additionalAnimatingNode.speed = 0
                        
                        self.plane.beginBurstAnimation(withCompletion: { [weak self] in
                            self?.plane.removeFromParent()
                            self?.pauseGame()
                        })
                    })
                } else if let shakingBody = contactBody as? Shaking {
                    shakingBody.beginShakeAnimation(withCompletion: { [weak self] in
                        self?.pauseGame()
                    })
                } else {
                    pauseGame()
                }
               }
                
                break
            
            case Categories.dollar.rawValue | Categories.superPower.rawValue:
                fallthrough
            case Categories.dollar.rawValue | Categories.plane.rawValue:
                
                var contactBody: SKNode?
                if contact.bodyA.node is Plane {
                    contactBody = contact.bodyB.node
                } else {
                    contactBody = contact.bodyA.node
                }
                let candy:Candy = contactBody as! Candy ////
                if !planeTouchCandy {
                planeTouchCandy = true
                candyType = candy.candyType
                candy.run(getCandyActionSequenceSequence(candy))
                //candy.physicsBody = nil
                
                delay(0.5, closure:  {
                    self.dollarWallet.beginDollarAnimation()
                    self.planeTouchCandy = false
                })
                }
                break

            case Categories.candyToDollar.rawValue | Categories.superPower.rawValue:
                fallthrough
            case Categories.candyToDollar.rawValue | Categories.plane.rawValue:
                var contactBody: SKNode?
                if contact.bodyA.node is Plane {
                    contactBody = contact.bodyB.node
                } else {
                    contactBody = contact.bodyA.node
                }
                let candyToDollar:CandyToDollars = contactBody as! CandyToDollars ////
                
                if !planeTouchDollar {
                    planeTouchDollar = true
                
               let qualityOfServiceIdentifier = DispatchQoS.QoSClass.background
                let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceIdentifier)
                backgroundQueue.async(execute: { 
                    
                    //  Play audio sound effects on user tap!
                    /*AudioPlayer.stop()
                    AudioPlayer.playCoinCollectionMusicFX()*/
                    //self.run(SKAction.playSoundFileNamed("Pulsing Laser.wav", waitForCompletion: false))
                    
                    self.playSound(sound: .coinCollection)
                    
                    DispatchQueue.main.async(execute: { () -> Void in
                        
                        
                        candyToDollar.isHidden = false
                        candyToDollar.dollar = CandyDollars.def(CandyType.def(self.candyType).Candy()).dollar()
                        
                        // Needs to be dynamic
                        candyToDollar.updateScoresCount()
                        candyToDollar.beginAnimation()
                        
                        updateDollarsToGameData(candyToDollar.dollar)
                        self.dollarWallet.updateDollarsCount()
                    })
                })
                 delay(0.5, closure:  {
                    self.planeTouchDollar = false
                    })
                }
                break
                
            case Categories.ammo.rawValue | Categories.hurdle.rawValue:
                
                guard (contact.bodyA.node?.name ?? "") != "stall" ||
                    (contact.bodyB.node?.name ?? "") != "stall" else { return }
                
                
                var ammo: Shootable?
                var hurdle: Damagable?
                
                if contact.bodyA.node is Shootable {
                    ammo = contact.bodyA.node as? Shootable
                    hurdle = contact.bodyB.node as? Damagable
                } else {
                    ammo = contact.bodyB.node as? Shootable
                    hurdle = contact.bodyA.node as? Damagable
                }
               
                if var damagableAmmo = ammo as? Damagable {
                    damagableAmmo.health -= 1
                    self.run(SKAction.playSoundFileNamed("001-3.mp3", waitForCompletion: false))
                    if damagableAmmo.health <= 0 {
                        (ammo as? SKNode)?.physicsBody?.categoryBitMask = 0
                        (ammo as? SKNode)?.physicsBody?.affectedByGravity = true
                    }
                }
                
                if contact.bodyA.node?.name == "lollipop" {
                   (contact.bodyA.node as! Crashable).beginCrashAnimation(withCompletion: nil)
                } else if contact.bodyB.node?.name == "lollipop" {
                   (contact.bodyB.node as! Crashable).beginCrashAnimation(withCompletion: nil)
                }
                
                guard hurdle != nil, ammo != nil else {
                    return
                }
                
                hurdle!.health -= ammo!.damage
                break
                
            case Categories.pathFinder.rawValue | Categories.score.rawValue:
                
                if(contact.bodyA.node is PathFinder || contact.bodyB.node is PathFinder){
                    self.pathFinder?.moveTo(yPoint: self.queueOfPathYPoints.dequeue()?.0)
                }
                else{
                    baloon.moveTo(yPoint: queueOfPathForBaloon.dequeue())
                }
             
                break
            default:
                break
                
            }
        }
    }
}
