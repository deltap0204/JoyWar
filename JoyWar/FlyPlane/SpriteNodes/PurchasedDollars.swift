//
//  PurchasedDollars.swift
//  FlyPlane
//
//  Created by Dexter on 25/06/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import UIKit
import SpriteKit

class PurchasedDollars: SKSpriteNode {
    
    let dollar = SKSpriteNode(imageNamed: "DollarSymbol")
    let dollarWallet = SKTexture(imageNamed: "DollarWalletSymbol")
    
    var dollar1stDigit = SKSpriteNode(imageNamed: "0")
    var dollar2ndDigit = SKSpriteNode(imageNamed: "0")
    var dollar3rdDigit = SKSpriteNode(imageNamed: "0")
    var dollar4thDigit = SKSpriteNode(imageNamed: "0")
    var dollar5thDigit = SKSpriteNode(imageNamed: "0")
    var dollar6thDigit = SKSpriteNode(imageNamed: "0")
    
    init() {
        super.init(texture: nil, color: UIColor(), size: CGSize(width: dollarWallet.size().width / 0.6, height: dollarWallet.size().height / 1.2))
        
        userInteractionEnabled = true
        
        dollar.name = "dollar"
        dollar.size = CGSize(width: dollar.size.width / 1.2, height: dollar.size.height / 1.2)
        dollar.position = CGPoint(x: position.x - dollar.size.width * 1.6, y: 0.0)
        addChild(dollar)
        
        dollar1stDigit.size = CGSize(width: dollar1stDigit.size.width / 1.5, height: dollar1stDigit.size.height / 1.5)
        dollar1stDigit.position = CGPoint(x: dollar.position.x + dollar1stDigit.size.width + dollar1stDigit.size.width * 2, y: position.y + dollar1stDigit.size.height / 16)
        dollar1stDigit.hidden = true
        addChild(dollar1stDigit)
        
        dollar2ndDigit.size = CGSize(width: dollar2ndDigit.size.width / 1.5, height: dollar2ndDigit.size.height / 1.5)
        dollar2ndDigit.position = CGPoint(x: dollar1stDigit.position.x + dollar2ndDigit.size.width + dollar2ndDigit.size.width * (1 / 10), y: position.y + dollar2ndDigit.size.height / 16)
        dollar2ndDigit.hidden = true
        addChild(dollar2ndDigit)
        
        dollar3rdDigit.size = CGSize(width: dollar3rdDigit.size.width / 1.5, height: dollar3rdDigit.size.height / 1.5)
        dollar3rdDigit.position = CGPoint(x: dollar2ndDigit.position.x + dollar3rdDigit.size.width + dollar3rdDigit.size.width * (1 / 10), y: position.y + dollar3rdDigit.size.height / 16)
        dollar3rdDigit.hidden = true
        addChild(dollar3rdDigit)
        
        dollar4thDigit.size = CGSize(width: dollar4thDigit.size.width / 1.5, height: dollar4thDigit.size.height / 1.5)
        dollar4thDigit.position = CGPoint(x: dollar3rdDigit.position.x + dollar4thDigit.size.width + dollar4thDigit.size.width * (1 / 10), y: position.y + dollar4thDigit.size.height / 16)
        dollar4thDigit.hidden = true
        addChild(dollar4thDigit)
        
        dollar5thDigit.size = CGSize(width: dollar5thDigit.size.width / 1.5, height: dollar5thDigit.size.height / 1.5)
        dollar5thDigit.position = CGPoint(x: dollar4thDigit.position.x + dollar5thDigit.size.width + dollar5thDigit.size.width * (1 / 10), y: position.y + dollar5thDigit.size.height / 16)
        dollar5thDigit.hidden = true
        addChild(dollar5thDigit)
        
        dollar6thDigit.size = CGSize(width: dollar6thDigit.size.width / 1.5, height: dollar6thDigit.size.height / 1.5)
        dollar6thDigit.position = CGPoint(x: dollar5thDigit.position.x + dollar6thDigit.size.width + dollar6thDigit.size.width * (1 / 10), y: position.y + dollar6thDigit.size.height / 16)
        dollar6thDigit.hidden = true
        addChild(dollar6thDigit)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateDollarsCount(purchasedDollars: Int) {
        let dollarsInNumberOfDigits:String = "\(purchasedDollars)"
        
        switch(dollarsInNumberOfDigits.characters.count) {
        case 1:
            dollar1stDigit.hidden = false
            dollar1stDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits)
            break
        case 2:
            dollar1stDigit.hidden = false
            dollar2ndDigit.hidden = false
            dollar1stDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[0])
            dollar2ndDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[1])
            break
        case 3:
            dollar1stDigit.hidden = false
            dollar2ndDigit.hidden = false
            dollar3rdDigit.hidden = false
            dollar1stDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[0])
            dollar2ndDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[1])
            dollar3rdDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[2])
            break
        case 4:
            dollar1stDigit.hidden = false
            dollar2ndDigit.hidden = false
            dollar3rdDigit.hidden = false
            dollar4thDigit.hidden = false
            dollar1stDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[0])
            dollar2ndDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[1])
            dollar3rdDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[2])
            dollar4thDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[3])
            break
        case 5:
            dollar1stDigit.hidden = false
            dollar2ndDigit.hidden = false
            dollar3rdDigit.hidden = false
            dollar4thDigit.hidden = false
            dollar5thDigit.hidden = false
            dollar1stDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[0])
            dollar2ndDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[1])
            dollar3rdDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[2])
            dollar4thDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[3])
            dollar5thDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[4])
            break
        case 6:
            dollar1stDigit.hidden = false
            dollar2ndDigit.hidden = false
            dollar3rdDigit.hidden = false
            dollar4thDigit.hidden = false
            dollar5thDigit.hidden = false
            dollar6thDigit.hidden = false
            dollar1stDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[0])
            dollar2ndDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[1])
            dollar3rdDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[2])
            dollar4thDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[3])
            dollar5thDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[4])
            dollar6thDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[5])
            break
            
        default:
            break
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var isFrontScene = false
        
        if let _ = parent as? FrontScene {
            isFrontScene = true
        }
        
        if (isFrontScene) {
            let parentScene: FrontScene = parent as! FrontScene
            parentScene.touchesBegan(touches, withEvent: event)
        } else {
            let parentScene: GameScene = parent as! GameScene
            parentScene.flag = true
            parentScene.touchesBegan(touches, withEvent: event)
        }
    }
    
    typealias CompletionHandler = (action: SKAction) -> Void
    
    func beginAnimation(completionHandler: CompletionHandler) {
        let moveUp = SKAction.moveToY(position.y + 75.0, duration: 1.0)
        let fadeOut = SKAction.fadeOutWithDuration(1.0)
        let animation = SKAction.group([moveUp, fadeOut])
        let sequence = SKAction.sequence([animation])
        completionHandler(action: sequence)
    }
    
    func fadeInAnimationBehindTheScene(completinHandler: CompletionHandler) {
        let fadeIn = SKAction.fadeInWithDuration(0.0)
        completinHandler(action: fadeIn)
    }
    
    func beginDollarAnimation() {
        let scale1By1 = SKAction.scaleTo(1.0, duration: 0.1)
        let scale3By4 = SKAction.scaleTo(0.90, duration: 0.1)
        let scale1By2 = SKAction.scaleTo(0.75, duration: 0.1)
        let scaleSequence = SKAction.sequence([scale3By4, scale1By2, scale3By4, scale1By1])
        dollar.runAction(scaleSequence)
    }
    
    func beginAlphaAnimation() {
        let alpha3By4 = SKAction.fadeAlphaTo(0.7, duration: 0.1)
        let alpha1By2 = SKAction.fadeAlphaTo(0.4, duration: 0.1)
        let alpha1By1 = SKAction.fadeAlphaTo(0.0, duration: 0.1)
        let alphaSequence = SKAction.sequence([alpha3By4, alpha1By2, alpha1By1])
        runAction(alphaSequence)
    }
    
}
