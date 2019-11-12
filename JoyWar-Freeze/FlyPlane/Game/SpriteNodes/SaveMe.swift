//
//  SaveMe.swift
//  FlyPlane
//
//  Created by Dexter on 04/05/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import SpriteKit

enum DollarsNeededForScore: NSInteger {
    case lessThanEqualToTen = 10
    case lessThanEqualToTwenty = 20
    case lessThanEqualToThirty = 30
    case lessThanEqualToFourty = 40
    case lessThanEqualToFifty = 50
    case lessThanEqualToSeventyFive = 60
    case lessThanEqualToHundred = 100
    case lessThanEqualToHundredAndFifty = 150
    case lessThanEqualToTwoHundred = 200
    case lessThanEqualToTwoHundredAndFifty = 250
    case lessThanEqualToFiveHundred = 500
    case lessThanEqualToSevenHundredAndFifty = 750
    case lessThanEqualToThousand = 1000
}

class SaveMe: SKSpriteNode {
    
    let saveMe = SKSpriteNode(imageNamed: "SaveMe")
    let buyDollars = SKSpriteNode(imageNamed: "BuyDollars_SaveMe")
    let close = SKSpriteNode(imageNamed: "Close")
    let menu = SKSpriteNode(imageNamed: "Menu")
    var dollarsRequiredForResumingGame = Int()
    
    var dollar1stDigit = SKSpriteNode(imageNamed: "0")
    var dollar2ndDigit = SKSpriteNode(imageNamed: "0")
    var dollar3rdDigit = SKSpriteNode(imageNamed: "0")
    var dollar4thDigit = SKSpriteNode(imageNamed: "0")
    var dollar5thDigit = SKSpriteNode(imageNamed: "0")
    var dollar6thDigit = SKSpriteNode(imageNamed: "0")
    
    init() {
        super.init(texture: nil, color: UIColor(), size: CGSize(width: saveMe.size.width, height: saveMe.size.height))
        
        isUserInteractionEnabled = true
        zPosition = 1
        
        let addPosition:CGFloat = -90
        
        buyDollars.name = "buyDollars"
        buyDollars.position = CGPoint(x: 0.0, y: 0.0 + addPosition)
        buyDollars.size = CGSize(width: buyDollars.size.width/4.5, height: buyDollars.size.height/4.5)
        buyDollars.zPosition = 1
        addChild(buyDollars)
        
        dollar1stDigit.name = "buyDollars"
        dollar1stDigit.size = CGSize(width: dollar1stDigit.size.width / 1.5, height: dollar1stDigit.size.height / 1.5)
        dollar1stDigit.position = CGPoint(x: -15.0, y: 0.0 + addPosition)
        dollar1stDigit.isHidden = true
        dollar1stDigit.zPosition = 1
        addChild(dollar1stDigit)
        
        dollar2ndDigit.name = "buyDollars"
        dollar2ndDigit.size = CGSize(width: dollar2ndDigit.size.width / 1.5, height: dollar2ndDigit.size.height / 1.5)
        dollar2ndDigit.position = CGPoint(x: dollar1stDigit.position.x + dollar2ndDigit.size.width + dollar2ndDigit.size.width * (1 / 10), y: position.y + dollar2ndDigit.size.height / 16 + addPosition)
        dollar2ndDigit.isHidden = true
        dollar2ndDigit.zPosition = 1
        addChild(dollar2ndDigit)
        
        dollar3rdDigit.name = "buyDollars"
        dollar3rdDigit.size = CGSize(width: dollar3rdDigit.size.width / 1.5, height: dollar3rdDigit.size.height / 1.5)
        dollar3rdDigit.position = CGPoint(x: dollar2ndDigit.position.x + dollar3rdDigit.size.width + dollar3rdDigit.size.width * (1 / 10), y: position.y + dollar3rdDigit.size.height / 16 + addPosition)
        dollar3rdDigit.isHidden = true
        dollar3rdDigit.zPosition = 1
        addChild(dollar3rdDigit)
        
        dollar4thDigit.name = "buyDollars"
        dollar4thDigit.size = CGSize(width: dollar4thDigit.size.width / 1.5, height: dollar4thDigit.size.height / 1.5)
        dollar4thDigit.position = CGPoint(x: dollar3rdDigit.position.x + dollar4thDigit.size.width + dollar4thDigit.size.width * (1 / 10), y: position.y + dollar4thDigit.size.height / 16 + addPosition)
        dollar4thDigit.isHidden = true
        dollar4thDigit.zPosition = 1
        addChild(dollar4thDigit)
        
        dollar5thDigit.name = "buyDollars"
        dollar5thDigit.size = CGSize(width: dollar5thDigit.size.width / 1.5, height: dollar5thDigit.size.height / 1.5)
        dollar5thDigit.position = CGPoint(x: dollar4thDigit.position.x + dollar5thDigit.size.width + dollar5thDigit.size.width * (1 / 10), y: position.y + dollar5thDigit.size.height / 16 + addPosition)
        dollar5thDigit.isHidden = true
        dollar5thDigit.zPosition = 1
        addChild(dollar5thDigit)
        
        dollar6thDigit.name = "buyDollars"
        dollar6thDigit.size = CGSize(width: dollar6thDigit.size.width / 1.5, height: dollar6thDigit.size.height / 1.5)
        dollar6thDigit.position = CGPoint(x: dollar5thDigit.position.x + dollar6thDigit.size.width + dollar6thDigit.size.width * (1 / 10), y: position.y + dollar6thDigit.size.height / 16 + addPosition)
        dollar6thDigit.isHidden = true
        dollar6thDigit.zPosition = 1
        addChild(dollar6thDigit)
        
        menu.name = "menuSaveMe"
        menu.size = CGSize(width: menu.size.width / 1.5, height: menu.size.height / 1.5)
        menu.position = CGPoint(x: menu.size.width + (menu.size.width / 5), y: -(menu.size.height / 1))
        menu.anchorPoint = CGPoint(x: 1.0, y: 1.0 + 2)
        menu.zPosition = 1
        addChild(menu)
        
        close.name = "close"
        close.size = menu.size
        close.position = CGPoint(x: -(close.size.width / 2) + (close.size.width / 5), y: -(close.size.height / 1))
        close.anchorPoint = CGPoint(x: 1.0, y: 1.0 + 2)
        close.zPosition = 1
        addChild(close)
        
        addChild(saveMe)
    }
    
    func getDollarsNeededForResumeBasedOnScore() -> Int {

        if GameScore <= DollarsNeededForScore.lessThanEqualToTen.rawValue {
            return 100
        }
        else if GameScore <= DollarsNeededForScore.lessThanEqualToTwenty.rawValue {
            return 500
        }
        else if GameScore <= DollarsNeededForScore.lessThanEqualToThirty.rawValue {
            return 1000
        }
        else if GameScore <= DollarsNeededForScore.lessThanEqualToFourty.rawValue {
            return 1500
        }
        else if GameScore <= DollarsNeededForScore.lessThanEqualToFifty.rawValue {
            return 2000
        }
        else if GameScore <= DollarsNeededForScore.lessThanEqualToSeventyFive.rawValue {
            return 2500
        }
        else if GameScore <= DollarsNeededForScore.lessThanEqualToHundred.rawValue {
            return 3000
        }
        else if GameScore <= DollarsNeededForScore.lessThanEqualToHundredAndFifty.rawValue {
            return 3500
        }
        else if GameScore <= DollarsNeededForScore.lessThanEqualToTwoHundred.rawValue {
            return 4000
        }
        else if GameScore <= DollarsNeededForScore.lessThanEqualToTwoHundredAndFifty.rawValue {
            return 4500
        }
        else if GameScore <= DollarsNeededForScore.lessThanEqualToFiveHundred.rawValue {
            return 8000
        }
        else if GameScore <= DollarsNeededForScore.lessThanEqualToSevenHundredAndFifty.rawValue {
            return 10000
        }
        else if GameScore <= DollarsNeededForScore.lessThanEqualToThousand.rawValue {
            return 12500
        }
        
        return 15000
    }
    
    func updateDollarsCount() {
        let dollarsInNumberOfDigits:String = "\(getDollarsNeededForResumeBasedOnScore())"
        dollarsRequiredForResumingGame = getDollarsNeededForResumeBasedOnScore()
        
        switch(dollarsInNumberOfDigits.characters.count) {
            
        case 1:
            dollar1stDigit.isHidden = false
            dollar1stDigit.texture = SKTexture(imageNamed: "\(getDollarsFromGameData())")
            break
        case 2:
            dollar1stDigit.isHidden = false
            dollar2ndDigit.isHidden = false
            dollar1stDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[0])
            dollar2ndDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[1])
            break
        case 3:
            dollar1stDigit.isHidden = false
            dollar2ndDigit.isHidden = false
            dollar3rdDigit.isHidden = false
            dollar1stDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[0])
            dollar2ndDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[1])
            dollar3rdDigit.texture = SKTexture(imageNamed: dollarsInNumberOfDigits[2])
            break
        case 4:
            dollar1stDigit.isHidden = false
            dollar2ndDigit.isHidden = false
            dollar3rdDigit.isHidden = false
            dollar4thDigit.isHidden = false
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
        let gameScene = parent as! GameScene
        gameScene.flag = true
        gameScene.touchesBegan(touches, with: event)        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    typealias CompletionHandler = (_ action: SKAction) -> Void
    
    func beginAnimation(_ completionHandler: CompletionHandler) {
        let scale0By1 = SKAction.scale(to: 0.0, duration: 0.0)
        let scale1By2 = SKAction.scale(to: 0.75, duration: 0.2)
        let scaleSequence = SKAction.sequence([scale0By1, scale1By2])
        
        completionHandler(scaleSequence)
    }
    
    func hideAnimation(_ completionHandler: CompletionHandler) {
        let scale0By1 = SKAction.scale(to: 0.0, duration: 0.0)
        let scale1By2 = SKAction.scale(to: 0.75, duration: 0.1)
        let scaleSequence = SKAction.sequence([scale1By2, scale0By1])
        
        completionHandler(scaleSequence)
    }
    
    func hideAnimationMenuTapped(_ completionHandler: CompletionHandler) {
        let scale0By1 = SKAction.scale(to: 0.0, duration: 0.1)
        let scaleSequence = SKAction.sequence([scale0By1])
        
        completionHandler(scaleSequence)
    }
}
