//
//  CoinsWallet.swift
//  FlyPlane
//
//  Created by Dexter on 30/04/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class DollarsWallet: SKSpriteNode {
    
    let wallet = SKSpriteNode(imageNamed: "DollarWalletOrange")
    let dollarSymbol = SKSpriteNode(imageNamed: "Dollar")
    var dollar1stDigit = SKSpriteNode(imageNamed: "Digit0")
    var dollar2ndDigit = SKSpriteNode(imageNamed: "Digit0")
    var dollar3rdDigit = SKSpriteNode(imageNamed: "Digit0")
    var dollar4thDigit = SKSpriteNode(imageNamed: "Digit0")
    var dollar5thDigit = SKSpriteNode(imageNamed: "Digit0")
    var dollar6thDigit = SKSpriteNode(imageNamed: "Digit0")
    var dollarsCollected:NSInteger! = 0
    
    init() {
        super.init(texture: nil, color: UIColor(), size: CGSize(width: wallet.size.width / 3, height: wallet.size.height / 3))
        
        wallet.size = CGSize(width: wallet.size.width / 4.5, height: wallet.size.height / 5)
        wallet.position = CGPoint(x: 0.0, y: 0.0)
        addChild(wallet)
        
        dollarSymbol.size = CGSize(width: dollarSymbol.size.width / 3.7, height: dollarSymbol.size.height / 3.7)
        dollarSymbol.position = CGPoint(x: wallet.position.x - wallet.size.width / 1.8 + dollarSymbol.size.width, y: wallet.position.y + dollarSymbol.size.height / 3)
        addChild(dollarSymbol)
        
        dollar1stDigit.size = CGSize(width: dollar1stDigit.size.width / 9, height: dollar1stDigit.size.height / 9)
        dollar1stDigit.position = CGPoint(x: dollarSymbol.position.x + dollar1stDigit.size.width + dollar1stDigit.size.width * (1 / 1.7), y: wallet.position.y + dollar1stDigit.size.height / 16)
        dollar1stDigit.hidden = false
        addChild(dollar1stDigit)
        
        dollar2ndDigit.size = CGSize(width: dollar2ndDigit.size.width / 9, height: dollar2ndDigit.size.height / 9)
        dollar2ndDigit.position = CGPoint(x: dollar1stDigit.position.x + dollar2ndDigit.size.width + dollar2ndDigit.size.width * (1 / 10), y: wallet.position.y + dollar2ndDigit.size.height / 16)
        dollar2ndDigit.hidden = false
        addChild(dollar2ndDigit)
        
        dollar3rdDigit.size = CGSize(width: dollar3rdDigit.size.width / 9, height: dollar3rdDigit.size.height / 9)
        dollar3rdDigit.position = CGPoint(x: dollar2ndDigit.position.x + dollar3rdDigit.size.width + dollar3rdDigit.size.width * (1 / 10), y: wallet.position.y + dollar3rdDigit.size.height / 16)
        dollar1stDigit.hidden = false
        addChild(dollar3rdDigit)
        
        dollar4thDigit.size = CGSize(width: dollar3rdDigit.size.width / 9, height: dollar3rdDigit.size.height / 9)
        dollar4thDigit.position = CGPoint(x: dollar3rdDigit.position.x + dollar4thDigit.size.width + dollar4thDigit.size.width * (1 / 10), y: wallet.position.y + dollar4thDigit.size.height / 16)
        dollar4thDigit.hidden = false
        addChild(dollar4thDigit)
        
        dollar5thDigit.size = CGSize(width: dollar3rdDigit.size.width / 9, height: dollar3rdDigit.size.height / 9)
        dollar5thDigit.position = CGPoint(x: dollar4thDigit.position.x + dollar5thDigit.size.width + dollar5thDigit.size.width * (1 / 10), y: wallet.position.y + dollar5thDigit.size.height / 16)
        dollar5thDigit.hidden = false
        addChild(dollar5thDigit)
        
        dollar6thDigit.size = CGSize(width: dollar3rdDigit.size.width / 9, height: dollar3rdDigit.size.height / 9)
        dollar6thDigit.position = CGPoint(x: dollar5thDigit.position.x + dollar6thDigit.size.width + dollar6thDigit.size.width * (1 / 10), y: wallet.position.y + dollar6thDigit.size.height / 16)
        dollar6thDigit.hidden = false
        addChild(dollar6thDigit)
        
        updateDollarsCount()        
    }
    
    func updateDollarsCount() {
//        let dollarsInNumberOfDigits:String = "\(dollarsCollected)"
//
//        switch(dollarsInNumberOfDigits.characters.count) {
//        case 1:
//            dollar3rdDigit.hidden = false
//            dollar3rdDigit.texture = SKTexture(imageNamed: "Digit\(dollarsCollected)")
//            break
//        case 2:
//            dollar3rdDigit.hidden = false
//            dollar2ndDigit.hidden = false
//            dollar3rdDigit.texture = SKTexture(imageNamed: "Digit" + dollarsInNumberOfDigits[1])
//            dollar2ndDigit.texture = SKTexture(imageNamed: "Digit" + dollarsInNumberOfDigits[0])
//            break
//        case 3:
//            dollar3rdDigit.hidden = false
//            dollar2ndDigit.hidden = false
//            dollar1stDigit.hidden = false
//            dollar3rdDigit.texture = SKTexture(imageNamed: "Digit" + dollarsInNumberOfDigits[2])
//            dollar2ndDigit.texture = SKTexture(imageNamed: "Digit" + dollarsInNumberOfDigits[1])
//            dollar1stDigit.texture = SKTexture(imageNamed: "Digit" + dollarsInNumberOfDigits[0])
//            break
//            
//        default:
//            break
//        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}