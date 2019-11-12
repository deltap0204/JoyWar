//
//  GameScene - touchesBegan.swift
//  Game
//
//  Created by Daniel Slupskiy on 31.03.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import Foundation
import SpriteKit
import StoreKit

extension GameScene {
    
    
    // MARK: Actions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if let node = atPoint(touches.first!.location(in: self)) as? RocketChanger {
            node.beginAnimation()
            Plane.currentRocketType = Plane.currentRocketType.getNext()
            plane.rocketDelegate?.updateRockets(count: PlayersBackpack.rocketsCount[Plane.currentRocketType]!)
            self.rocketIndicator.texture = SKTexture(image: Plane.currentRocketType.getIndicatorImage())
        }
        
        if isAnimating == false {
            if isTheGamePaused == true {
                if isTheGameResumed == true {
                    isTheGamePaused = false
                    isTheGameResumed = false
                    isAnimating = true
                    resumedHurdle.run(moveResumedHurdleAndRemove())
                    mountain.beginAnimation()
                    ground.beginAnimation()
                    road.beginAnimation()
                    beginEndlessHurdles()
                    
                    delay(0.7, closure: {
                        self.beginEndlessAdditionalHurdles()
                    })
                }
            } else {
                if flag == true {
                    let touch:UITouch = touches.first!
                    let positionInScene = touch.location(in: self)
                    let node = self.atPoint(positionInScene)
                    
                    var nodeName = String()
                    
                    if node.name == nil {
                        nodeName = "empty"
                    } else {
                        nodeName = node.name!
                    }
                    
                    //  Play audio sound effects on user tap!
                    /*AudioPlayer.stop()
                    AudioPlayer.playJumpOrButtonMusicFX()*/
                    
                    //playSound(sound: .planeJump)
                    self.run(SKAction.playSoundFileNamed("006-6.mp3", waitForCompletion: false))
                    switch(nodeName) {
                    case "plus", "DollarWallet", "dollar":
                        if !self.isAnimating {
                            if self.inAppPurchase.xScale > 0.0 || self.saveMe.xScale > 0.0 || self.gameOver.xScale > 0.0{
                                return
                            }
                            self.dollarWallet.beginAnimation()
                            delay(0.3, closure: { () -> () in
                                self.inAppPurchase.beginAnimation({ (action) -> Void in
                                    self.inAppPurchase.run(action)
                                })
                            })
                        }
                        self.flag = false
                        return
                    case "back":
                        let back = node as! Button
                        back.beginAnimation()
                        
                        delay(0.2, closure: {
                            self.inAppPurchase.hideAnimation({ (action) -> Void in
                                self.inAppPurchase.run(action, completion: { () -> Void in
                                })
                            })
                        })
                        self.flag = false
                        return
                    case "Point99":
                        let buyPoint99 = node as! Button
                        buyPoint99.iAPButtonBeginAnimation()
                        delay(0.3, closure: {
                            let identifier = ShopManager.ProductIdWithDollars.keyForValue(value: 500)
                            ShopManager.purchaseProduct(withIdentifier: identifier!, withCompletion: { (success) in
                                self.dollarWallet.updateDollarsCount()
                            })
                        })
                        break
                    case "2Point99":
                        let buy2Point99 = node as! Button
                        buy2Point99.iAPButtonBeginAnimation()
                        delay(0.3, closure: {
                            let identifier = ShopManager.ProductIdWithDollars.keyForValue(value: 1500)
                            ShopManager.purchaseProduct(withIdentifier: identifier!, withCompletion: { (success) in
                                self.dollarWallet.updateDollarsCount()
                            })
                        })
                        break
                    case "5Point99":
                        let buy5Point99 = node as! Button
                        buy5Point99.iAPButtonBeginAnimation()
                        
                        delay(0.3, closure: {
                            let identifier = ShopManager.ProductIdWithDollars.keyForValue(value: 4000)
                            ShopManager.purchaseProduct(withIdentifier: identifier!, withCompletion: { (success) in
                                self.dollarWallet.updateDollarsCount()
                            })
                        })
                        break
                    case "19Point99":
                        let buy19Point99 = node as! Button
                        buy19Point99.iAPButtonBeginAnimation()
                        
                        delay(0.3, closure: {
                            let identifier = ShopManager.ProductIdWithDollars.keyForValue(value: 10000)
                            ShopManager.purchaseProduct(withIdentifier: identifier!, withCompletion: { (success) in
                                self.dollarWallet.updateDollarsCount()
                            })
                        })
                        break
                    case "59Point99":
                        let buy59Point99 = node as! Button
                        buy59Point99.iAPButtonBeginAnimation()
                        
                        delay(0.3, closure: {
                            let identifier = ShopManager.ProductIdWithDollars.keyForValue(value: 30000)
                            ShopManager.purchaseProduct(withIdentifier: identifier!, withCompletion: { (success) in
                                self.dollarWallet.updateDollarsCount()
                            })
                        })
                        break
                    case "99Point99":
                        let buy99Point99 = node as! Button
                        buy99Point99.iAPButtonBeginAnimation()
                        
                        delay(0.3, closure: {
                            let identifier = ShopManager.ProductIdWithDollars.keyForValue(value: 100000)
                            ShopManager.purchaseProduct(withIdentifier: identifier!, withCompletion: { (success) in
                                self.dollarWallet.updateDollarsCount()
                            })
                        })
                        break
                    default:
                        break
                    }
                }
                
                if inAppPurchase.xScale > 0.0 || self.gameOver.xScale > 0.0 || self.gameOver.xScale > 0.0 {
                    return
                }
                
                guard atPoint(touches.first!.location(in: self)) as? HeightControl != nil else {
                    return
                }
                
                mountain.beginAnimation()
                ground.beginAnimation()
                road.beginAnimation()
                beginEndlessHurdles()
                
                delay(0.7, closure: {
                    self.beginEndlessAdditionalHurdles()
                })
                
                isAnimating = true
            }
        }
        
        if flag == true {
            
            let touch:UITouch = touches.first!
            let positionInScene = touch.location(in: self)
            let node = self.atPoint(positionInScene)
            
            var nodeName = String()
            
            if node.name == nil {
                nodeName = "empty"
            } else {
                nodeName = node.name!
            }
            
            let qualityOfServiceIdentifier = DispatchQoS.QoSClass.background
            let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceIdentifier)
            backgroundQueue.async(execute: {
                
                //self.playSound(sound: .planeJump)
                self.run(SKAction.playSoundFileNamed("006-6.mp3", waitForCompletion: false))
                DispatchQueue.main.async(execute: { () -> Void in
                })
            })
            
            switch(nodeName) {
            case "buyDollars":
                //TODO: Perform store purchase option
                let dollarsFromGameData: NSInteger = getDollarsFromGameData()
                let dollarsRequired: NSInteger = self.saveMe.dollarsRequiredForResumingGame
                
                if (dollarsFromGameData > dollarsRequired) {
                    self.saveMe.hideAnimation({ (action) -> Void in
                        self.saveMe.run(action, completion: { () -> Void in
                            
                            let dollarsBeforeDeduction = getDollarsFromGameData()
                            
                            let dollarsAfterDeduction = dollarsBeforeDeduction - dollarsRequired

                            insertDollarsToGameData(dollarsAfterDeduction)
                            self.protocolDelegate?.presentGameScene(true)
                        })
                    })
                } else {
                    
                    let identifier = ShopManager.ProductIdWithDollars.keyForValue(value: self.saveMe.dollarsRequiredForResumingGame)
                    
                    //print("Identifier: " + identifier!)
                    
                    self.showInGameStore(productType: .none, triedProduct: identifier!)
                }
            case "close":
                DispatchQueue.main.async(execute: { () -> Void in
                    //print(GameScene.lossCounter)
                    if GameScene.lossCounter >= 2 {
                        GameScene.lossCounter = 0
                        if !isAdBlocked {
                            Chartboost.showInterstitial(CBLocationHomeScreen)
                        }
                    }
                    else{
                        GameScene.lossCounter += 1
                    }
                })

                self.updateScoreAndHighScoreToGameData()
                self.saveMe.hideAnimation({ (action) -> Void in
                    self.saveMe.run(action, completion: { () -> Void in
                        self.gameOver.beginAnimation({ (action) -> Void in
                            self.gameOver.run(action, completion: { () -> Void in
                            })
                        })
                    })
                })
                break
            case "menuShareFacebook":
                if !waitingForAdv{
                    viewController?.shareOnFacebook(scene:self, score: GameScore)
                }
                break
            case "menuGameOver":
                if !waitingForAdv{
                initializeScoreToGameData(0)
                gameOver.hideAnimation({ (action) -> Void in
                    self.gameOver.run(action, completion: { () -> Void in
                        delay(0.2, closure: { () -> () in
                            
                            self.protocolDelegate?.presentFrontScene()
                        })
                    })
                })
                }
                break
            case "menuSaveMe":
                self.saveMe.hideAnimationMenuTapped({ (action) -> Void in
                    self.saveMe.run(action, completion: { () -> Void in
                        
                        self.protocolDelegate?.presentFrontScene()
                    })
                })
                break
            case "reload":
                
                if waitingForAdv {
                }
                
                if !waitingForAdv{
                initializeScoreToGameData(0)
                isPaused = false
                self.gameOver.hideAnimation({ (action) -> Void in
                    self.gameOver.run(action, completion: { () -> Void in
                        delay(0.2, closure: { () -> () in
                            self.protocolDelegate?.presentGameScene(false)
                           /* for child in self.children{
                                child.removeAllChildren()
                                child.removeAllActions()
                            }
                            self.removeAllChildren()
                            self.removeAllActions()
                            self.setupProperties()*/

                            
                        })
                    })
                })
                }
                break
            case "store":
                if !waitingForAdv{
                //TODO: Perform store purchase option
                self.gameOver.hideAnimation({ (action) -> Void in
                    self.gameOver.run(action, completion: { () -> Void in
                        self.inAppPurchase.beginAnimation({ (action) -> Void in
                            self.inAppPurchase.run(action, completion: { () -> Void in
                            })
                        })
                    })
                })
                }
                break
            case "Point99":
                let buyPoint99 = node as! Button
                buyPoint99.iAPButtonBeginAnimation()
                
                delay(0.3, closure: {
                    let identifier = ShopManager.ProductIdWithDollars.keyForValue(value: 500)
                    ShopManager.purchaseProduct(withIdentifier: identifier!, withCompletion: { (success) in
                        self.dollarWallet.updateDollarsCount()
                    })
                })
                break
            case "2Point99":
                let buy2Point99 = node as! Button
                buy2Point99.iAPButtonBeginAnimation()
                
                delay(0.3, closure: {
                    let identifier = ShopManager.ProductIdWithDollars.keyForValue(value: 1500)
                    ShopManager.purchaseProduct(withIdentifier: identifier!, withCompletion: { (success) in
                        self.dollarWallet.updateDollarsCount()
                    })
                })
                break
            case "5Point99":
                let buy5Point99 = node as! Button
                buy5Point99.iAPButtonBeginAnimation()
                
                delay(0.3, closure: {
                    let identifier = ShopManager.ProductIdWithDollars.keyForValue(value: 4000)
                    ShopManager.purchaseProduct(withIdentifier: identifier!, withCompletion: { (success) in
                        self.dollarWallet.updateDollarsCount()
                    })
                })
                break
            case "19Point99":
                let buy19Point99 = node as! Button
                buy19Point99.iAPButtonBeginAnimation()
                
                delay(0.3, closure: {
                    let identifier = ShopManager.ProductIdWithDollars.keyForValue(value: 10000)
                    ShopManager.purchaseProduct(withIdentifier: identifier!, withCompletion: { (success) in
                        self.dollarWallet.updateDollarsCount()
                    })
                })
                break
            case "59Point99":
                let buy59Point99 = node as! Button
                buy59Point99.iAPButtonBeginAnimation()
                
                delay(0.3, closure: {
                    let identifier = ShopManager.ProductIdWithDollars.keyForValue(value: 30000)
                    ShopManager.purchaseProduct(withIdentifier: identifier!, withCompletion: { (success) in
                        self.dollarWallet.updateDollarsCount()
                    })
                })
                break
            case "99Point99":
                let buy99Point99 = node as! Button
                buy99Point99.iAPButtonBeginAnimation()
                
                delay(0.3, closure: {
                    let identifier = ShopManager.ProductIdWithDollars.keyForValue(value: 100000)
                    ShopManager.purchaseProduct(withIdentifier: identifier!, withCompletion: { (success) in
                        self.dollarWallet.updateDollarsCount()
                    })
                })
                break
            case "back":
                let back = node as! Button
                back.beginAnimation()
                delay(0.2, closure: {
                    self.inAppPurchase.hideAnimation({ (action) -> Void in
                        self.inAppPurchase.run(action, completion: { () -> Void in
                            self.gameOver.beginAnimation({ (action) -> Void in
                                self.gameOver.run(action)
                            })
                        })
                    })
                })
                break
            case "plus":
                if !isAnimating {
                    if self.inAppPurchase.xScale > 0.0 || self.saveMe.xScale > 0.0 || self.gameOver.xScale > 0.0{
                        return
                    }
                    self.dollarWallet.beginAnimation()
                    delay(0.3, closure: { () -> () in
                        self.inAppPurchase.beginAnimation({ (action) -> Void in
                            self.inAppPurchase.run(action)
                        })
                    })
                    
                }
                break
            default:
                break
            }
        }
        
        if (flag == true) {
            flag = false
            return
        }
        
        
        // control tapped
        
        if atPoint(touches.first!.location(in: self)) is BubbleIndicator {
            if !plane.isBalloonEnabled && !isPopupOpened {
                if PlayersBackpack.bubblesCount>0 {
                    self.run(SKAction.playSoundFileNamed("006-4.mp3", waitForCompletion: false))
                    activate(superPower: .bubble)
                }
                else{
                    showGameStore(productType: .bubble)
                    sceneOnPause()
                    setupBubbleAfterStore = true
                }
            }
        }
        
        if let node = atPoint(touches.first!.location(in: self)) as? RocketIndicator {
            if PlayersBackpack.rocketsCount[Plane.currentRocketType]! > 0 {
            node.beginAnimation()
                self.run(SKAction.playSoundFileNamed("006-0.mp3", waitForCompletion: false))
                plane.shootRocket()
            }
            else{
                showGameStore(productType: StoreProductType(rawValue: Plane.currentRocketType.rawValue)!)
                sceneOnPause()
            }
        }
        
        if let node = atPoint(touches.first!.location(in: self)) as? PathFinderControl {
            if PlayersBackpack.pathFinderCount>0 {
                self.run(SKAction.playSoundFileNamed("006-3.mp3", waitForCompletion: false))
                pathFinderActivate()
            }
            else{
                showGameStore(productType: .pathFinder)
                sceneOnPause()
            }

            
        }
        
        
        if atPoint(touches.first!.location(in: self)) is BalloonControl {
            if(connectionRope == nil && !Enemy.isShown && !plane.isBubbleEnabled){
                if PlayersBackpack.balloonCount>0{
                    balloonActivate()
                    //balloonControl.beginAnimation()
                    self.run(SKAction.playSoundFileNamed("006-5.mp3", waitForCompletion: false))
                    ballonControl.beginAnimation()
                    //ballonControl.beginDigitsAnimation()
                
                } else{
                    showGameStore(productType: .balloon)
                    sceneOnPause()
                    setupBalloonAfterStore = true
                }
            }
            

          
        }

        
        if let node = atPoint(touches.first!.location(in: self)) as? ShootControll {
            if PlayersBackpack.bulletsCount > 0{
            plane.bulletsCount =  PlayersBackpack.bulletsCount
            node.beginAnimation()
            self.run(SKAction.playSoundFileNamed("006-1.mp3", waitForCompletion: false))
            plane.enableMachineGun()
        
            } else{
                showGameStore(productType: .bullet)
                sceneOnPause()
            }
        }
        
        guard let node = atPoint(touches.first!.location(in: self)) as? HeightControl else {
            return
        }
        
        node.beginAnimation()
        
        makePlaneJump(withDirection: node.direction)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        shootingControl.endAnimation()
        plane.disableMachineGun()
    }
}
