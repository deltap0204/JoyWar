//
//  MenuScene.swift
//  FlyPlane
//
//  Created by Dexter on 04/05/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import SpriteKit
import StoreKit

class FrontScene: SKScene {
    
    var protocolDelegate : PresentGameScene?
    
    let plane = Plane()
    let play = Play()
    let ground = Ground()
    let road = Road()
    let mountain = Mountain()
    let title = Title()
    var button:Button? = nil
    let dollarWallet = DollarWallet()
    let purchasedDollarsWallet = PurchasedDollars()
    var bannerButton = BannerButton(type: "")
    let inAppPurchase = InAppPurchase()
    var flag = Bool()
    
    override func didMoveToView(view: SKView) {
        createSky()
        createTitle()
        createPlayButton()
        createPlane()
        createGround()
        createRoad()
        createMountain()
        createStore()
        createLeaderboard()
        createSound()
        createMute()
        createFacebook()
        createTwitter()
        createDollarWallet()
        createPurchasedDollars()
        createRemoveAds()
        createHighScore()
        createInAppPurchase()
        subscribeToStoreManagerDelegate()
    }
    
    func createSky() {
        let topColor = CIColor(color: UIColor(red: 13.0 / 255.0, green: 179.0 / 255.0, blue: 249.0 / 255.0, alpha: 1.0))
        let bottomColor = CIColor(color: UIColor(red: 233.0 / 255.0, green: 255.0 / 255.0, blue: 253.0 / 255.0, alpha: 1.0))
        
        let texture = SKTexture(size: CGSize(width: size.width, height: size.height), endColor: bottomColor, startColor: topColor)
        texture.filteringMode = .Nearest
        
        let sprite = SKSpriteNode(texture: texture)
        sprite.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame))
        sprite.physicsBody?.categoryBitMask = Categories.World.rawValue
        sprite.size = size
        sprite.zPosition = 0
        
        addChild(sprite)
    }
    
    func createTitle() {
        title.position = CGPoint(x: size.width / 2, y: size.height / 1.4)
        addChild(title)
    }
    
    func createPlayButton() {
        play.position = CGPoint(x: size.width / 2, y: size.height / 3.0)
        play.name = "play"
        addChild(play)
    }
    
    func createPlane() {
        plane.position = CGPoint(x: size.width / 2, y: size.height / 2.2)
        plane.beginAnimation()
        plane.beginStartUpAnimation()
        addChild(plane)
    }
    
    func createGround() {
        ground.physicsBody?.categoryBitMask = Categories.World.rawValue
        ground.physicsBody?.dynamic = false
        ground.beginAnimation()
        addChild(ground)
    }
    
    func createRoad() {
        road.position = CGPoint(x: ground.position.x, y: ground.position.y + road.size.height - 10.0)
        road.physicsBody?.categoryBitMask = Categories.World.rawValue
        road.physicsBody?.dynamic = false
        road.beginAnimation()
        
        addChild(road)
    }

    func createMountain() {
        mountain.position = CGPoint(x: road.position.x, y: road.position.y + mountain.size.height / 2)
        mountain.beginAnimation()
        addChild(mountain)
    }
    
    func createStore() {
        button = Button(imageNamed: "Store")
        button?.name = "Store"
        button?.position = CGPoint(x: size.width / 1.5, y: (button?.size.height)! / 2 + 7.0)
        addChild(button!)
    }
    
    func createLeaderboard() {
        button = Button(imageNamed: "Leaderboard")
        button?.name = "Leaderboard"
        button?.position = CGPoint(x: size.width / 3.0, y: (button?.size.height)! / 2 + 7.0)
        addChild(button!)
    }
    
    func createDollarWallet() {
        dollarWallet.name = "DollarWallet"
        dollarWallet.position = CGPoint(x: size.width / 2.5, y: size.height / 1.05)
        dollarWallet.updateDollarsCount()
        addChild(dollarWallet)
    }
    
    func createPurchasedDollars() {
        purchasedDollarsWallet.name = "PurchasedDollars"
        purchasedDollarsWallet.position = CGPoint(x: dollarWallet.position.x, y: dollarWallet.position.y - 100.0)
        purchasedDollarsWallet.hidden = true
        addChild(purchasedDollarsWallet)
    }
    
    func createRemoveAds() {
        bannerButton = BannerButton(type: "RemoveAds")
        bannerButton.position = CGPoint(x: size.width / 3.21, y: size.height / 2.5)
//        addChild(bannerButton)
    }
    
    func createHighScore() {
        bannerButton = BannerButton(type: "HighScore")
        bannerButton.position = CGPoint(x: size.width / 1.45, y: size.height / 2.5)
//        addChild(bannerButton)
    }
    
    func createInAppPurchase() {
        inAppPurchase.setScale(0.0)
        inAppPurchase.position = CGPoint(x: size.width / 2, y: size.height / 2)
        inAppPurchase.progressBar.hidden = true
        inAppPurchase.progressBar.beginAnimation()
        addChild(inAppPurchase)
    }
    
    func createMute() {
        button = Button(imageNamed: "Mute")
        button?.name = "Mute"
        button?.setScale(0.65)
        button?.position = CGPoint(x: size.width / 1.48, y: size.height / 1.05)
        button?.hidden = !GameMuteState
        addChild(button!)
    }
    
    func createFacebook() {
        button = Button(imageNamed: "Facebook")
        button?.name = "Facebook"
        button?.setScale(0.50)
        button?.position = CGPoint(x: size.width / 1.48, y: size.height / 1.12)
        addChild(button!)
    }
    
    func createTwitter() {
        button = Button(imageNamed: "Twitter")
        button?.name = "Twitter"
        button?.setScale(0.50)
        button?.position = CGPoint(x: size.width / 1.48, y: size.height / 1.19)
        addChild(button!)
    }
    
    func createSound() {
        button = Button(imageNamed: "Sound")
        button?.name = "Sound"
        button?.setScale(0.65)
        button?.position = CGPoint(x: size.width / 1.48, y: size.height / 1.05)
        button?.hidden = GameMuteState
        addChild(button!)
    }
    
    func subscribeToStoreManagerDelegate() {
        StoreManager.sharedInstance.delegate = self
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let touch:UITouch = touches.first!
        let positionInScene = touch.locationInNode(self)
        let node = self.nodeAtPoint(positionInScene)
        
        var nodeName = String()
        
        if node.name == nil {
            nodeName = "empty"
        } else {
            nodeName = node.name!
        }
        
        //  Play audio sound effects on user tap!
        AudioPlayer.playJumpOrButtonMusicFX()
        
        switch(nodeName) {
            case "play":
                play.beginAnimation()
                play.beginAlphaAnimation()
                plane.beginAlphaAnimation(false)
                dollarWallet.beginAlphaAnimation()
                
                let storePosition = CGPoint(x: 684.138061523438, y: 42.0270080566406)
                let store = self.nodeAtPoint(storePosition) as! Button
                store.beginAlphaAnimation()
                
                let leaderboardPosition = CGPoint(x: 349.649200439453, y: 47.2084045410156)
                let leaderboard = self.nodeAtPoint(leaderboardPosition) as! Button
                leaderboard.beginAlphaAnimation()
                
                let soundPostion = CGPoint(x: 688.743774414062, y: 723.670227050781)
                let sound = self.nodeAtPoint(soundPostion) as! Button
                let mute = self.nodeAtPoint(soundPostion) as! Button
                sound.beginSoundAlphaAnimation()
                mute.beginSoundAlphaAnimation()
                
                let facebookPosition = CGPoint(x: 695.076599121094, y: 684.521789550781)
                let facebook = self.nodeAtPoint(facebookPosition) as! Button
                facebook.beginAlphaAnimation()
                
                let twitterPosition = CGPoint(x: 699.682250976562, y: 644.221923828125)
                let twitter = self.nodeAtPoint(twitterPosition) as! Button
                twitter.beginAlphaAnimation()
                
                delay(0.3, closure: {
                    self.title.beginAnimation()
                })
                delay(0.7, closure: {
                    if let delegate = self.protocolDelegate {
                        delegate.presentGameScene(false)
                    }
                })
                
                break
            case "Store":
                let button = node as! Button
                button.beginAnimation()
                delay(0.05, closure: { 
                    if self.inAppPurchase.xScale > 0.0 {
                        return
                    }
                    delay(0.05, closure: { () -> () in
                        self.inAppPurchase.beginAnimation({ (action) -> Void in
                            self.inAppPurchase.runAction(action)
                        })
                    })
                })
                break
            case  "Leaderboard":
                let button = node as! Button
                button.beginAnimation()
                
                break
            case "Mute":
                let button = node as! Button
                button.beginSoundAnimation()
                
                break
            case "Sound":
                let button = node as! Button
                button.beginSoundAnimation()
                
                break
            case "Facebook":
                let button = node as! Button
                button.beginSocialNetWorkingAnimation()
                
                break
            case "Twitter":
                let button = node as! Button
                button.beginSocialNetWorkingAnimation()
                
                break
            case "Point99":
                let buyPoint99 = node as! Button
                buyPoint99.beginAnimation()
                
                inAppPurchase.progressBar.hidden = false
                
                delay(0.3, closure: {
                    for (_, product) in StoreManager.sharedInstance.loadedProducts.enumerate() {
                        if product.productIdentifier == "com.Studio2Entertainment.FlyPlane.HundredDollars"{
                            StoreManager.sharedInstance.purchaseProduct(product)
                        }
                    }
                })
                break
            case "2Point99":
                let buy2Point99 = node as! Button
                buy2Point99.beginAnimation()
                
                inAppPurchase.progressBar.hidden = false
                
                delay(0.3, closure: {
                    for (_, product) in StoreManager.sharedInstance.loadedProducts.enumerate() {
                        if product.productIdentifier == "com.Studio2Entertainment.FlyPlane.FiHundredDollars" {
                            StoreManager.sharedInstance.purchaseProduct(product)
                        }
                    }
                })
                break
            case "5Point99":
                let buy5Point99 = node as! Button
                buy5Point99.beginAnimation()
                
                inAppPurchase.progressBar.hidden = false
                
                delay(0.3, closure: {
                    for (_, product) in StoreManager.sharedInstance.loadedProducts.enumerate() {
                        if product.productIdentifier == "com.Studio2Entertainment.FlyPlane.TwoThousandDollars" {
                            StoreManager.sharedInstance.purchaseProduct(product)
                        }
                    }
                })
                break
            case "19Point99":
                let buy19Point99 = node as! Button
                buy19Point99.beginAnimation()
                
                inAppPurchase.progressBar.hidden = false
                
                delay(0.3, closure: {
                    for (_, product) in StoreManager.sharedInstance.loadedProducts.enumerate() {
                        if product.productIdentifier == "com.Studio2Entertainment.FlyPlane.FiveThousandDollars" {
                            StoreManager.sharedInstance.purchaseProduct(product)
                        }
                    }
                })
                break
            case "59Point99":
                let buy59Point99 = node as! Button
                buy59Point99.beginAnimation()
                
                inAppPurchase.progressBar.hidden = false
                
                delay(0.3, closure: {
                    for (_, product) in StoreManager.sharedInstance.loadedProducts.enumerate() {
                        if product.productIdentifier == "com.Studio2Entertainment.FlyPlane.FiftyThousandDollars" {
                            StoreManager.sharedInstance.purchaseProduct(product)
                        }
                    }
                })
                break
            case "99Point99":
                let buy99Point99 = node as! Button
                buy99Point99.beginAnimation()
                
                inAppPurchase.progressBar.hidden = false
                
                delay(0.3, closure: {
                    for (_, product) in StoreManager.sharedInstance.loadedProducts.enumerate() {
                        if product.productIdentifier == "com.Studio2Entertainment.FlyPlane.OneLakhDollars" {
                            StoreManager.sharedInstance.purchaseProduct(product)
                        }
                    }
                })
                break
            case "back":
                let back = node as! Button
                back.beginAnimation()
                
                inAppPurchase.progressBar.hidden = true
                
                delay(0.2, closure: {
                    self.inAppPurchase.hideAnimation({ (action) -> Void in
                        self.inAppPurchase.runAction(action, completion: { () -> Void in
                        })
                    })
                })
                break
            case "plus", "DollarWallet", "dollar":
                if self.inAppPurchase.xScale > 0.0 {
                    return
                }
                self.dollarWallet.beginAnimation()
                delay(0.3, closure: { () -> () in
                    self.inAppPurchase.beginAnimation({ (action) -> Void in
                        self.inAppPurchase.runAction(action)
                    })
                })
                break
            default:
                break
        }
    }
}

extension FrontScene: StoreManagerDelegate {
    func updateWithProducts(products: [SKProduct]) { }
    
    func purchaseFailed(reason: String) {
        
        self.inAppPurchase.progressBar.hidden = true
        showAlert("Purcahse Failed", message: "Please try again!", buttonTitle: "Ok")
    }
    
    func refreshPurchaseStatus(purchasedDollars: Int) {
        
        self.inAppPurchase.progressBar.hidden = true
        
        self.inAppPurchase.hideAnimation({ (action) -> Void in
            self.inAppPurchase.runAction(action, completion: { () -> Void in
                //TODO: Animate on screen about successful purchase!
                self.purchasedDollarsWallet.updateDollarsCount(purchasedDollars)
                self.purchasedDollarsWallet.hidden = false
                self.purchasedDollarsWallet.beginAnimation({ (action) in
                    self.purchasedDollarsWallet.runAction(action)
                    delay(1.0, closure: {
                        //  Play purchased coins added to the dollar wallet animation
                        AudioPlayer.playCoinsAddedToWalletMusicFX()
                        
                        self.dollarWallet.beginDollarAnimation()
                        delay(0.1, closure: {
                            self.dollarWallet.beginDollarUpdateAnimation()
                            delay(0.05, closure: {                                 
                                self.dollarWallet.updateDollarsCount()
                                self.purchasedDollarsWallet.hidden = true
                                self.purchasedDollarsWallet.fadeInAnimationBehindTheScene({ (action) in
                                    self.purchasedDollarsWallet.runAction(action)
                                })
                                self.purchasedDollarsWallet.position.y = self.purchasedDollarsWallet.position.y - 75.0
                            })
                        })
                    })
                })
            })
        })
    }
}