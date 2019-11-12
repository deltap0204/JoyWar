//
//  BaseScene.swift
//  Game
//
//  Created by Daniel Slupskiy on 30.03.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import Foundation
import SpriteKit

enum audioFileNames{
    case planeJump
    case coinCollection
    case dollarWalletCoins
    case gameOver
    
    // 001
    case planeFlying
    case planeUp
    case planeDown
    case whirlybirdGotHit
    case whirlybirdDead
    case whirlybirdCatches
    case collectsCandy
    // 002
    case activeBubble

    
    var getAudioFileName: String {
        switch self {
        case .planeJump:
            return "Bubble.wav"
        case .coinCollection:
            return "001-6.mp3"//"Pulsing Laser.wav"
        case .dollarWalletCoins:
            return "coin collect.wav"
        case .gameOver:
            return "Game Over fx.wav"
        case .planeFlying:
            return "001-0.mp3"
        case .planeUp:
            return "001-1.mp3"
        case .planeDown:
            return "001-2.mp3"
        case .whirlybirdGotHit:
            return "001-3.mp3"
        case .whirlybirdDead:
            return "001-4.mp3"
        case .whirlybirdCatches:
            return "001-5.mp3"
        case .collectsCandy:
            return "001-6.mp3"
        case .activeBubble:
            return "002-0.mp3"
        }
    }
    
    

}

class BaseScene: SKScene {

    var viewController: GameViewController? = nil
    var plane = Plane()
    
    var isPopupOpened = false
    
    var store: StoreView? = nil {
        didSet {
            isPopupOpened = store != nil
        }
    }
    
    var inGameStore: InGameStoreView? = nil {
        didSet {
            isPopupOpened = inGameStore != nil
        }
    }
    
    var tutorial: TutorialView? = nil {
        didSet {
            isPopupOpened = tutorial != nil
        }
    }
    
    var pauseBackground = SKSpriteNode()
    
    func playSound(sound : audioFileNames){
        if !GameMuteState {self.run(SKAction.playSoundFileNamed(sound.getAudioFileName, waitForCompletion: false))}
    
    }

    func playForeverSound(sound : audioFileNames) {
        
        self.run(SKAction.repeatForever(SKAction.playSoundFileNamed(sound.getAudioFileName, waitForCompletion: true)), withKey: "repeat")
    }
    

    func stopSound() {
        self.run(SKAction.stop())
    }
    
    func showGameStore(productType : StoreProductType){
        guard !isPopupOpened else { return }
        
        guard productType != .none else {
            return
        }
        
        let storeFromNib: StoreView = Bundle.main.loadNibNamed("StoreView",
                                                              owner: nil,
                                                              options: nil)?.first as! StoreView
        storeFromNib.type = productType
        storeFromNib.productArray = storeFromNib.type.getProductArray()

        let size = (self.view?.frame.width)! < (self.view?.frame.height)! ? (self.view?.frame.width)! : (self.view?.frame.height)!
        ////print(size)
        
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone {
            storeFromNib.frame = CGRect(x:5,y:100,width:285*size/285/1.2,height:461*size/285/1.2)}
        else{
            storeFromNib.frame = CGRect(x:5,y:100,width:285*size/285/1.5,height:461*size/285/1.5/1.5)
        }
        
        
        
        storeFromNib.center = self.scene!.view!.center
        storeFromNib.scene = self
        
        self.view?.addSubview(storeFromNib)
        store = storeFromNib
        
        
    }
    
    func showInGameStore(productType : StoreProductType, triedProduct: String) -> Void {
                
        let inGameStoreFromNib: InGameStoreView = Bundle.main.loadNibNamed("InGameStoreView",
                                                                           owner: nil,
                                                                           options: nil)?.first as! InGameStoreView
        if store != nil {
            inGameStoreFromNib.type = store?.type
        }
        else {
            inGameStoreFromNib.type = productType
        }
        
        inGameStoreFromNib.productArray.insert(triedProduct, at: 0)
        
        let size = (self.view?.frame.width)! < (self.view?.frame.height)! ? (self.view?.frame.width)! : (self.view?.frame.height)!
        
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone {
            inGameStoreFromNib.frame = CGRect(x:5,y:100,width:285*size/285/1.2,height:461*size/285/1.2)}
        else{
            inGameStoreFromNib.frame = CGRect(x:5,y:100,width:285*size/285/1.5,height:461*size/285/1.5/1.5)
        }
                
        inGameStoreFromNib.center = self.scene!.view!.center
        inGameStoreFromNib.scene = self
        
        self.view?.addSubview(inGameStoreFromNib)
        inGameStore = inGameStoreFromNib
        
        store?.removeFromSuperview()
    }
    
    func showGameTutorial(){
        guard !isPopupOpened else { return }
        
        loadPauseBackground()
        
        let tutorialFromNib: TutorialView = Bundle.main.loadNibNamed("TutorialView",
                                                                  owner: nil,
                                                                   options: nil)?.first as! TutorialView

        
        let scaleFactor = CGFloat(0.9)
        tutorialFromNib.frame.size = CGSize(width: self.view!.frame.size.height*0.65*scaleFactor,
                                            height: self.view!.frame.size.height*scaleFactor)
        tutorialFromNib.center = self.scene!.view!.center
        tutorialFromNib.center.y -= 20
        tutorialFromNib.scene = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.view?.addSubview(tutorialFromNib)
        }
        tutorial = tutorialFromNib
    }
    
    
    func changeStorePositionOnRotation(){
        
        if let currentStore = store{
            delay(0.2, closure: {
                currentStore.center = self.scene!.view!.center})
            
        }
    
    }
    
    func loadPauseBackground(){
        
        guard pauseBackground.parent == nil else {
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let duration = 0.3
            self.pauseBackground = GameViewController.getBluredScreenshot(ofScene: self)
            var multiplier = self.size.height / self.pauseBackground.size.height
            multiplier *= CGFloat(1.05)
            self.pauseBackground.size.width *= multiplier
            self.pauseBackground.size.height *= multiplier
            
            self.pauseBackground.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
            self.pauseBackground.alpha = 0
            self.pauseBackground.zPosition = 3
            self.pauseBackground.run(SKAction.fadeAlpha(to: 1, duration: duration))
            
            self.addChild(self.pauseBackground)
        }
       
        if self is GameScene {
            DispatchQueue.main.async {
                (self as! GameScene).dollarWallet.isHidden = false
                (self as! GameScene).scoreWallet.isHidden = false
            }
        }
        
        
    }

}
