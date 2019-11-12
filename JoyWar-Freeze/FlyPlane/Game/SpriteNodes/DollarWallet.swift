//
//  DollarWallet.swift
//  FlyPlane
//
//  Created by Dexter on 06/05/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class DollarWallet: SKSpriteNode {
    
    let dollar = SKSpriteNode(imageNamed: "DollarSymbol")
    let dollarWallet = SKTexture(image: #imageLiteral(resourceName: "DollarWalletSymbol"))
    let plus = SKSpriteNode(imageNamed: "PlusSymbol")
    
    var dollar1stDigit = SKSpriteNode(imageNamed: "0")
    var dollar2ndDigit = SKSpriteNode(imageNamed: "0")
    var dollar3rdDigit = SKSpriteNode(imageNamed: "0")
    var dollar4thDigit = SKSpriteNode(imageNamed: "0")
    var dollar5thDigit = SKSpriteNode(imageNamed: "0")
    var dollar6thDigit = SKSpriteNode(imageNamed: "0")
    
    init() {
        super.init(texture: dollarWallet, color: UIColor(), size: CGSize(width: dollarWallet.size().width / 1.2, height: dollarWallet.size().height / 1.2))
        
        
        
        isUserInteractionEnabled = true
        
        dollar.name = "dollar"
        dollar.size = CGSize(width: dollar.size.width / 1.2, height: dollar.size.height / 1.2)
        dollar.position = CGPoint(x: position.x - dollar.size.width * 1.6, y: 0.0)
        addChild(dollar)
        
        plus.name = "plus"
        plus.size = CGSize(width: plus.size.width / 1.3, height: plus.size.height / 1.3)
        plus.position = CGPoint(x: position.x + dollar.size.width * 1.3, y: 0.0)
        addChild(plus)
        
        dollar1stDigit.size = CGSize(width: dollar1stDigit.size.width / 1.5, height: dollar1stDigit.size.height / 1.5)
        dollar1stDigit.position = CGPoint(x: dollar.position.x + dollar1stDigit.size.width + dollar1stDigit.size.width * 2, y: position.y + dollar1stDigit.size.height / 16)
        dollar1stDigit.isHidden = true
        addChild(dollar1stDigit)
        
        dollar2ndDigit.size = CGSize(width: dollar2ndDigit.size.width / 1.5, height: dollar2ndDigit.size.height / 1.5)
        dollar2ndDigit.position = CGPoint(x: dollar1stDigit.position.x + dollar2ndDigit.size.width + dollar2ndDigit.size.width * (1 / 10), y: position.y + dollar2ndDigit.size.height / 16)
        dollar2ndDigit.isHidden = true
        addChild(dollar2ndDigit)
        
        dollar3rdDigit.size = CGSize(width: dollar3rdDigit.size.width / 1.5, height: dollar3rdDigit.size.height / 1.5)
        dollar3rdDigit.position = CGPoint(x: dollar2ndDigit.position.x + dollar3rdDigit.size.width + dollar3rdDigit.size.width * (1 / 10), y: position.y + dollar3rdDigit.size.height / 16)
        dollar3rdDigit.isHidden = true
        addChild(dollar3rdDigit)
        
        dollar4thDigit.size = CGSize(width: dollar4thDigit.size.width / 1.5, height: dollar4thDigit.size.height / 1.5)
        dollar4thDigit.position = CGPoint(x: dollar3rdDigit.position.x + dollar4thDigit.size.width + dollar4thDigit.size.width * (1 / 10), y: position.y + dollar4thDigit.size.height / 16)
        dollar4thDigit.isHidden = true
        addChild(dollar4thDigit)
        
        dollar5thDigit.size = CGSize(width: dollar5thDigit.size.width / 1.5, height: dollar5thDigit.size.height / 1.5)
        dollar5thDigit.position = CGPoint(x: dollar4thDigit.position.x + dollar5thDigit.size.width + dollar5thDigit.size.width * (1 / 10), y: position.y + dollar5thDigit.size.height / 16)
        dollar5thDigit.isHidden = true
        addChild(dollar5thDigit)
        
        dollar6thDigit.size = CGSize(width: dollar6thDigit.size.width / 1.5, height: dollar6thDigit.size.height / 1.5)
        dollar6thDigit.position = CGPoint(x: dollar5thDigit.position.x + dollar6thDigit.size.width + dollar6thDigit.size.width * (1 / 10), y: position.y + dollar6thDigit.size.height / 16)
        dollar6thDigit.isHidden = true
        addChild(dollar6thDigit)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateDollarsCount() {
            let dollarsInNumberOfDigits:String = "\(getDollarsFromGameData())"
    
            switch(dollarsInNumberOfDigits.characters.count) {
            case 1:
                dollar1stDigit.isHidden = false
                dollar2ndDigit.isHidden = true
                dollar3rdDigit.isHidden = true
                dollar4thDigit.isHidden = true
                dollar5thDigit.isHidden = true
                dollar6thDigit.isHidden = true
                dollar1stDigit.texture = SKTexture(imageNamed: "\(getDollarsFromGameData())")
                break
            case 2:
                dollar1stDigit.isHidden = false
                dollar2ndDigit.isHidden = false
                dollar3rdDigit.isHidden = true
                dollar4thDigit.isHidden = true
                dollar5thDigit.isHidden = true
                dollar6thDigit.isHidden = true
                dollar1stDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[0])
                dollar2ndDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[1])
                break
            case 3:
                dollar1stDigit.isHidden = false
                dollar2ndDigit.isHidden = false
                dollar3rdDigit.isHidden = false
                dollar4thDigit.isHidden = true
                dollar5thDigit.isHidden = true
                dollar6thDigit.isHidden = true
                dollar1stDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[0])
                dollar2ndDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[1])
                dollar3rdDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[2])
                break
            case 4:
                dollar1stDigit.isHidden = false
                dollar2ndDigit.isHidden = false
                dollar3rdDigit.isHidden = false
                dollar4thDigit.isHidden = false
                dollar5thDigit.isHidden = true
                dollar6thDigit.isHidden = true
                dollar1stDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[0])
                dollar2ndDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[1])
                dollar3rdDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[2])
                dollar4thDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[3])
                break
            case 5:
                dollar1stDigit.isHidden = false
                dollar2ndDigit.isHidden = false
                dollar3rdDigit.isHidden = false
                dollar4thDigit.isHidden = false
                dollar5thDigit.isHidden = false
                dollar6thDigit.isHidden = true
                dollar1stDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[0])
                dollar2ndDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[1])
                dollar3rdDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[2])
                dollar4thDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[3])
                dollar5thDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[4])
                break
            case 6:
                dollar1stDigit.isHidden = false
                dollar2ndDigit.isHidden = false
                dollar3rdDigit.isHidden = false
                dollar4thDigit.isHidden = false
                dollar5thDigit.isHidden = false
                dollar6thDigit.isHidden = false
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var isFrontScene = false
        
        if let _ = parent as? FrontScene {
            isFrontScene = true
        }
        
        if (isFrontScene) {
            let parentScene: FrontScene = parent as! FrontScene
            parentScene.touchesBegan(touches, with: event)
        } else {
            let parentScene: GameScene = parent as! GameScene
            parentScene.flag = true
            parentScene.touchesBegan(touches, with: event)
        }
    }
    
    func beginAnimation() {
        let scale1By1 = SKAction.scale(to: 1.0, duration: 0.05)
        let scale3By4 = SKAction.scale(to: 0.90, duration: 0.05)
        let scale1By2 = SKAction.scale(to: 0.75, duration: 0.05)
        let scaleSequence = SKAction.sequence([scale3By4, scale1By2, scale3By4, scale1By1])
        run(scaleSequence)
    }
    
    func beginDollarUpdateAnimation() {
        let scale1By1 = SKAction.scale(to: 1.0, duration: 0.05)
        let scale3By4 = SKAction.scale(to: 0.90, duration: 0.05)
        let scale1By2 = SKAction.scale(to: 0.75, duration: 0.05)
        let scaleSequence = SKAction.sequence([scale3By4, scale1By2, scale3By4, scale1By1])
        
        dollar1stDigit.run(scaleSequence)
        dollar2ndDigit.run(scaleSequence)
        dollar3rdDigit.run(scaleSequence)
        dollar4thDigit.run(scaleSequence)
        dollar5thDigit.run(scaleSequence)
        dollar6thDigit.run(scaleSequence)
    }
    
    func beginDollarAnimation() {
        let scale1By1 = SKAction.scale(to: 1.0, duration: 0.1)
        let scale3By4 = SKAction.scale(to: 0.90, duration: 0.1)
        let scale1By2 = SKAction.scale(to: 0.75, duration: 0.1)
        let scaleSequence = SKAction.sequence([scale3By4, scale1By2, scale3By4, scale1By1])
        dollar.run(scaleSequence)
    }
    
    func beginAlphaAnimation() {
        let alpha3By4 = SKAction.fadeAlpha(to: 0.7, duration: 0.1)
        let alpha1By2 = SKAction.fadeAlpha(to: 0.4, duration: 0.1)
        let alpha1By1 = SKAction.fadeAlpha(to: 0.0, duration: 0.1)
        let alphaSequence = SKAction.sequence([alpha3By4, alpha1By2, alpha1By1])
        run(alphaSequence)
    }
    
    func beginBubbleAnimation() {
        let scale1By1 = SKAction.scale(to: 1.0, duration: 0.20)
        let scale3By4 = SKAction.scale(to: 0.9, duration: 0.10)
        let scale1By3 = SKAction.scale(to: 1.0, duration: 0.10)
        let scale1By2 = SKAction.scale(to: 0.8, duration: 0.10)
        let wait = SKAction.wait(forDuration: 1.0)
        let scaleSequence =  SKAction.repeatForever(SKAction.sequence([scale3By4, scale1By2, scale1By3, scale3By4, scale1By1, wait]))
        run(scaleSequence)
    }
    
}
