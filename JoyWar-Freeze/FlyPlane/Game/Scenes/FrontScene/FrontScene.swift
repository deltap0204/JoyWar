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
import Social

class FrontScene: BaseScene, RemoveAdsDelegate {
    
    var protocolDelegate : SceneDelegate?
    
    let muteButton = Button(imageNamed: "Mute")
    let soundButton = Button(imageNamed: "Sound")
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
    var shootingControl = ShootControll()
    var bubbleIndicator = BubbleIndicator()
    var rocketIndicator = RocketIndicator()
    var rocketChanger = RocketChanger()
    var pathFinderControl = PathFinderControl()
    var balloonControl = BalloonControl()
    
    var flag = Bool()
    
    override func willMove(from view: SKView) {
        
        StoreKitManager.shared.delegate = nil
        super.willMove(from: view)
    }
    
    override func didMove(to view: SKView) {
        
        createSky()
        createTitle()
        createPlayButton()
        createPlane()
        createGround()
        createRoad()
        createMountain()
        createEarnCoins()
        createRestore()
//        createRestorePurchases()
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
        bannerButton.addChildNodeWith("RemoveAds")
        
        StoreKitManager.shared.delegate = self
        
        createControls()
        self.viewController?.adBannerView.isHidden = true
        
        subscribeToStoreManagerDelegate()
        
        Chartboost.setDelegate(self)
        Chartboost.cacheRewardedVideo(CBLocationMainMenu)
        Chartboost.cacheInterstitial(CBLocationMainMenu)
        
        //StoreKitManager.shared.restorePurchases { _ in }
    }
    
    func updateMuteSoundState() {
        soundButton.isHidden = GameMuteState
        muteButton.isHidden = !GameMuteState
        
        if GameMuteState {
            AudioPlayer.shared.audioPlayer?.volume = 0
        } else {
            AudioPlayer.shared.audioPlayer?.volume = 1
        }
    }
    
    func subscribeToStoreManagerDelegate() {
        //StoreManager.sharedInstance.delegate = self
    }
    
    func updateCounters() {
        updateCounterWithId(0)
        updateCounterWithId(1)
        updateCounterWithId(2)
        updateCounterWithId(3)
        updateCounterWithId(4)
    }
    
    func updateCounterWithId(_ id: Int){
        switch id {
        case 0: self.bubbleIndicator.updateCounter()
        case 1: self.shootingControl.updateBullets(count: PlayersBackpack.bulletsCount)
        case 2: self.balloonControl.updateCounter()
        case 3: self.pathFinderControl.updateCounter()
        default:
            self.rocketIndicator.updateCounter(with: PlayersBackpack.rocketsCount[Plane.currentRocketType]!)
            self.rocketIndicator.texture = SKTexture(image: Plane.currentRocketType.getIndicatorImage())
        }
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let node = self.atPoint(positionInScene)
        
        var nodeName = String()
        
        if node.name == nil {
            nodeName = "empty"
        } else {
            nodeName = node.name!
        }
        
        switch(nodeName) {
            case "play":
                play.beginAnimation()
                play.beginAlphaAnimation()
                plane.beginAlphaAnimation(false)
                dollarWallet.beginAlphaAnimation()
                shootingControl.beginAlphaAnimation()
                bubbleIndicator.beginAlphaAnimation()
                rocketIndicator.beginAlphaAnimation()
                rocketChanger.beginAlphaAnimation()
                pathFinderControl.beginAlphaAnimation()
                balloonControl.beginAlphaAnimation()
                
                self.run(SKAction.playSoundFileNamed("006-7.mp3", waitForCompletion: true))
                
                let soundPostion = CGPoint(x: 688.743774414062, y: 723.670227050781)
                let sound = atPoint(soundPostion) as! Button
                let mute = atPoint(soundPostion) as! Button
                sound.beginSoundAlphaAnimation()
                mute.beginSoundAlphaAnimation()
                
                let facebookPosition = CGPoint(x: 695.076599121094, y: 684.521789550781)
                let facebook = self.atPoint(facebookPosition) as! Button
                facebook.beginAlphaAnimation()
                
                let twitterPosition = CGPoint(x: 699.682250976562, y: 644.221923828125)
                let twitter = atPoint(twitterPosition) as! Button
                twitter.beginAlphaAnimation()
                
                let earnCoinsPosition = CGPoint(x: size.width / 2, y: 140)
                let earnCoins = atPoint(earnCoinsPosition) as! Button
                earnCoins.beginAlphaAnimation()
                
                let tutorialPosition = CGPoint(x: size.width / 2, y: 190)
                let tutorial = atPoint(tutorialPosition) as! Button
                tutorial.beginAlphaAnimation()
                
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
                self.isPopupOpened = true
                let button = node as! Button
                button.beginAnimation()
                
                delay(0.05, closure: { 
                    if self.inAppPurchase.xScale > 0.0 {
                        return
                    }
                    delay(0.05, closure: { () -> () in
                        self.inAppPurchase.beginAnimation({ (action) -> Void in
                            self.inAppPurchase.run(action)
                        })
                    })
                })
                
                break
            case  "Leaderboard":
                let button = node as! Button
                button.beginAnimation()
                
                break
            case "Mute":
                guard !isPopupOpened else { return }
                let button = node as! Button
                button.beginSoundAnimation()
                GameMuteState = false
                updateMuteSoundState()
                
                break
        case "Sound":
            guard !isPopupOpened else { return }
                let button = node as! Button
                button.beginSoundAnimation()
                GameMuteState = true
                updateMuteSoundState()
                
                break
        case "Facebook":
            guard !isPopupOpened else { return }
                let button = node as! Button
                button.beginSocialNetWorkingAnimation()
                viewController?.shareOnFacebook(scene:self, score: nil)
                
                break
        case "Twitter":
            guard !isPopupOpened else { return }
                let button = node as! Button
                button.beginSocialNetWorkingAnimation()
                viewController?.shareOnTwitter(scene:self, score: nil)
                
                break
        case "Tutorial":
            let button = node as! Button
            button.beginSocialNetWorkingAnimation()
            self.showGameTutorial()
            break
            // MARK: Coins
        case "EarnCoins":
            guard !isPopupOpened else { return }
                let back = node as! Button
                back.beginSocialNetWorkingAnimation()
                videoButtonTapped() // Staring add
                //print(">>> EarnPoints")
                break
            
        case "Restore":
            let button = node as! Button
            button.beginSocialNetWorkingAnimation()
            StoreKitManager.shared.restorePurchase()
            break
            
            case "Point99":
                let buyPoint99 = node as! Button
                buyPoint99.iAPButtonBeginAnimation()
                
                delay(0.3, closure: {
                    
                    let identifier = ShopManager.ProductIdWithDollars.keyForValue(value: 500)
                    //print("Identifier:\(identifier!)")
                    ShopManager.purchaseProduct(withIdentifier: identifier!, withCompletion: { (success) in
                        if success {
                            self.dollarWallet.updateDollarsCount()
                        }
                    })
                })
                break
            case "2Point99":
                let buy2Point99 = node as! Button
                buy2Point99.iAPButtonBeginAnimation()
                
                delay(0.3, closure: {
                    
                    let identifier = ShopManager.ProductIdWithDollars.keyForValue(value: 1500)
                    //print("Identifier:\(identifier!)")
                    ShopManager.purchaseProduct(withIdentifier: identifier!, withCompletion: { (success) in
                        if success {
                            self.dollarWallet.updateDollarsCount()
                        }
                    })
                })
                break
            case "5Point99":
                let buy5Point99 = node as! Button
                buy5Point99.iAPButtonBeginAnimation()
                
                delay(0.3, closure: {
                    
                    let identifier = ShopManager.ProductIdWithDollars.keyForValue(value: 4000)
                    //print("Identifier:\(identifier!)")
                    ShopManager.purchaseProduct(withIdentifier: identifier!, withCompletion: { (success) in
                        if success {
                            self.dollarWallet.updateDollarsCount()
                        }
                    })
                })
                break
            case "19Point99":
                let buy19Point99 = node as! Button
                buy19Point99.iAPButtonBeginAnimation()
                
                delay(0.3, closure: {
                    
                    let identifier = ShopManager.ProductIdWithDollars.keyForValue(value: 10000)
                    //print("Identifier:\(identifier!)")
                    ShopManager.purchaseProduct(withIdentifier: identifier!, withCompletion: { (success) in
                        if success {
                            self.dollarWallet.updateDollarsCount()
                        }
                    })
                })
                break
            case "59Point99":
                let buy59Point99 = node as! Button
                buy59Point99.iAPButtonBeginAnimation()
                
                delay(0.3, closure: {
                    
                    let identifier = ShopManager.ProductIdWithDollars.keyForValue(value: 30000)
                    //print("Identifier:\(identifier!)")
                    ShopManager.purchaseProduct(withIdentifier: identifier!, withCompletion: { (success) in
                        if success {
                            self.dollarWallet.updateDollarsCount()
                        }
                    })
                })
                break
            case "99Point99":
                let buy99Point99 = node as! Button
                buy99Point99.iAPButtonBeginAnimation()
                
                delay(0.3, closure: {
                    
                    let identifier = ShopManager.ProductIdWithDollars.keyForValue(value: 100000)
                    //print("Identifier:\(identifier!)")
                    ShopManager.purchaseProduct(withIdentifier: identifier!, withCompletion: { (success) in
                        if success {
                            self.dollarWallet.updateDollarsCount()
                        }
                    })
                })
                break
            case "back":
                self.isPopupOpened = false
                let back = node as! Button
                back.beginAnimation()
                
                delay(0.2, closure: {
                    self.inAppPurchase.hideAnimation({ (action) -> Void in
                        self.inAppPurchase.run(action, completion: { () -> Void in
                        })
                    })
                })
                break
            
            case "RemoveAds":
                
                guard !isPopupOpened else { return }
                
                let identifier = ShopManager.ProductIdWithDollars.keyForValue(value: 0)
                //print("Identifier: " + identifier!)
                ShopManager.purchaseProduct(withIdentifier: identifier!, withCompletion: { (success) in
                    if success {                        
                        isAdBlocked = true
                        node.removeFromParent()
                    }
                })
                
                break
            
            case "plus", "DollarWallet", "dollar":
                guard !isPopupOpened else { return } 
                self.isPopupOpened = true
                if self.inAppPurchase.xScale > 0.0 {
                    return
                }
                self.dollarWallet.beginAnimation()
                delay(0.3, closure: { () -> () in
                    self.inAppPurchase.beginAnimation({ (action) -> Void in
                        self.inAppPurchase.run(action)
                    })
                })
                break
            default:
                
                guard !isPopupOpened else { return }
                
                if atPoint(touches.first!.location(in: self)) is BubbleIndicator {
                    if(!plane.isBalloonEnabled) {
                        
                        showGameStore(productType: .bubble)
                        
                    }
                }
                
                if let node = atPoint(touches.first!.location(in: self)) as? RocketIndicator {
                    
                    showGameStore(productType: StoreProductType(rawValue: Plane.currentRocketType.rawValue)!)
                }
                
                if let node = atPoint(touches.first!.location(in: self)) as? RocketChanger {
                    node.beginAnimation()
                    Plane.currentRocketType = Plane.currentRocketType.getNext()
                    rocketIndicator.updateCounter(with: PlayersBackpack.rocketsCount[Plane.currentRocketType]!)
                    self.rocketIndicator.texture = SKTexture(image: Plane.currentRocketType.getIndicatorImage())
                }
                if let node = atPoint(touches.first!.location(in: self)) as? PathFinderControl {
                    
                    showGameStore(productType: .pathFinder)
                    
                }
                
                
                if atPoint(touches.first!.location(in: self)) is BalloonControl {
                    
                    showGameStore(productType: .balloon)
                }
                
                
                if let node = atPoint(touches.first!.location(in: self)) as? ShootControll {
                    showGameStore(productType: .bullet)
                }

                
                break
            
        }
        
       self.run(SKAction.playSoundFileNamed("006-6.mp3", waitForCompletion: false))
    }
    
    
    func removeAds() {
        
        guard let node = childNode(withName: "RemoveAds") else {
            return
        }
        
        isAdBlocked = true
        node.removeFromParent()
    }

    func videoButtonTapped() {
        if Chartboost.hasRewardedVideo(CBLocationMainMenu) {
            Chartboost.showRewardedVideo(CBLocationMainMenu)
        } else {
            showAlert("Try later", message: "No rewarded videos available right now", buttonTitle: "OK")
        }
    }
}
