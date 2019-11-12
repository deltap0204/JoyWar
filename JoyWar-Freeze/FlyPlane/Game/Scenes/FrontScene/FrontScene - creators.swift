//
//  FrontScene - creators.swift
//  Game
//
//  Created by Daniel Slupskiy on 30.03.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import Foundation
import SpriteKit

extension FrontScene {
    func createSky() {
        let topColor = CIColor(color: UIColor(red: 13.0 / 255.0, green: 179.0 / 255.0, blue: 249.0 / 255.0, alpha: 1.0))
        let bottomColor = CIColor(color: UIColor(red: 233.0 / 255.0, green: 255.0 / 255.0, blue: 253.0 / 255.0, alpha: 1.0))
        
        let texture = SKTexture(size: CGSize(width: size.width, height: size.height), endColor: bottomColor, startColor: topColor)
        texture.filteringMode = .nearest
        
        let sprite = SKSpriteNode(texture: texture)
        sprite.position = CGPoint(x: frame.midX, y: frame.midY)
        sprite.physicsBody?.categoryBitMask = Categories.world.rawValue
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
        
        self.playSound(sound: audioFileNames.planeFlying)
    }
    
    func createGround() {
        ground.physicsBody?.categoryBitMask = Categories.world.rawValue
        ground.physicsBody?.isDynamic = false
        ground.beginAnimation()
        addChild(ground)
    }
    
    func createRoad() {
        road.position = CGPoint(x: ground.position.x, y: ground.position.y + road.size.height - 10.0)
        road.physicsBody?.categoryBitMask = Categories.world.rawValue
        road.physicsBody?.isDynamic = false
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
        button?.size = balloonControl.size
        button?.position = CGPoint(x: size.width / 6.0 * 5 / 2  + size.width / 6 * 3 / 2, y: (button?.size.height)! / 2 + 30.0 + balloonControl.size.height)
        //addChild(button!)
    }
    
    func createLeaderboard() {
        button = Button(imageNamed: "Leaderboard")
        button?.name = "Leaderboard"
        button?.size = balloonControl.size
        button?.position = CGPoint(x: size.width / 6.0 / 2 + size.width / 6 * 3 / 2 , y: (button?.size.height)! / 2 + 30.0 + balloonControl.size.height)
        //addChild(button!)
    }
    
    
    func createDollarWallet() {
        dollarWallet.name = "DollarWallet"
        dollarWallet.position = CGPoint(x: size.width / 2.5, y: size.height / 1.05)
        dollarWallet.updateDollarsCount()
        dollarWallet.beginBubbleAnimation()
        addChild(dollarWallet)
    }
    
    func createPurchasedDollars() {
        purchasedDollarsWallet.name = "PurchasedDollars"
        purchasedDollarsWallet.position = CGPoint(x: dollarWallet.position.x, y: dollarWallet.position.y - 100.0)
        purchasedDollarsWallet.isHidden = true
        addChild(purchasedDollarsWallet)
    }
    
    func createRemoveAds() {
        guard !isAdBlocked else {
            return
        }
        
        bannerButton = BannerButton(type: "RemoveAds")
        bannerButton.name = "RemoveAds"
        bannerButton.position = CGPoint(x: size.width / 3.1675 + 3, y: size.height / 3.0 + 40)
        addChild(bannerButton)
    }
    
    func createHighScore() {
        bannerButton = BannerButton(type: "HighScore")
        bannerButton.position = CGPoint(x: size.width / 1.45, y: size.height / 2.5)
    }
    
    func createInAppPurchase() {
        inAppPurchase.setScale(0.0)
        inAppPurchase.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(inAppPurchase)
    }
    
    func createMute() {
        muteButton.name = "Mute"
        muteButton.setScale(0.65)
        muteButton.position = CGPoint(x: size.width / 1.48, y: size.height / 1.05)
        muteButton.isHidden = !GameMuteState
        addChild(muteButton)
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
    
    func createEarnCoins() {
        button = Button(imageNamed: "FreeCoins")
        button?.name = "EarnCoins"
        button?.setScale(0.60)
        button?.position = CGPoint(x: size.width / 2, y: 180)
        addChild(button!)
    }
    
    func createRestore() {
        button = Button(imageNamed: "Restore-1")
        button?.name = "Restore"
        button?.setScale(0.60)
        button?.position = CGPoint(x: size.width / 1.98, y: 130)
        addChild(button!)
    }
    
    func createRestorePurchases() -> Void {
        button = Button(imageNamed: "Restore")
        button?.name = "Restore"
        button?.setScale(0.60)
        button?.position = CGPoint(x: size.width / 2, y: 90)
        addChild(button!)
    }
    
    func createSound() {
        soundButton.name = "Sound"
        soundButton.setScale(0.65)
        soundButton.position = CGPoint(x: size.width / 1.48, y: size.height / 1.05)
        soundButton.isHidden = GameMuteState
        addChild(soundButton)
    }
    
    func createControls() {
 
        balloonControl.position.x = size.width / 6.0 / 2 + size.width / 6 * 3 / 2
        balloonControl.position.y = balloonControl.size.height / 2 + 12.0
        balloonControl.zPosition = 3
        balloonControl.size = shootingControl.size
        balloonControl.beginBubbleAnimation()
        addChild(balloonControl)
        
        bubbleIndicator.position.x = size.width/6 * 3 / 2 + size.width / 6 * 3 / 2
        bubbleIndicator.position.y = balloonControl.position.y
        bubbleIndicator.zPosition = 3
        bubbleIndicator.size = shootingControl.size
        bubbleIndicator.beginBubbleAnimation()
        addChild(bubbleIndicator)
        
        rocketIndicator.position.x = size.width / 6.0 * 5 / 2  + size.width / 6 * 3 / 2
        rocketIndicator.position.y = balloonControl.position.y
        rocketIndicator.zPosition = 3
        rocketIndicator.size = shootingControl.size
        rocketIndicator.beginBubbleAnimation()
        addChild(rocketIndicator)
        
        
        rocketChanger.position.x = size.width / 6.0 * 5 / 2  + size.width / 6 * 3 / 2.24 + 7
        rocketChanger.position.y = balloonControl.position.y + rocketIndicator.size.height/2
        rocketChanger.size = CGSize(width: soundButton.size.width/1.25, height: soundButton.size.height/1.25)
        rocketChanger.zPosition = 3
        rocketChanger.beginBubbleAnimation()
        addChild(rocketChanger)
        
        pathFinderControl.position.x = size.width/6 * 2 / 2 + size.width / 6 * 3 / 2
        pathFinderControl.position.y = balloonControl.position.y
        pathFinderControl.size = balloonControl.size
        pathFinderControl.zPosition = 3
        pathFinderControl.beginBubbleAnimation()
        addChild(pathFinderControl)
        
        shootingControl.position.x = size.width/6 * 4 / 2 + size.width / 6 * 3 / 2
        shootingControl.position.y = balloonControl.position.y
        shootingControl.beginBubbleAnimation()
        shootingControl.zPosition = 3
        
        addChild(shootingControl)
        rocketIndicator.updateCounter(with: PlayersBackpack.rocketsCount[Plane.currentRocketType]!)
        updateCounters()
        
        
        
        
    }

}
