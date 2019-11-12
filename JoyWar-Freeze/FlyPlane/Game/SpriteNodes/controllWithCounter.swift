//
//  controllWithCounter.swift
//  Game
//
//  Created by Developer on 14.07.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import UIKit
import SpriteKit

class controllWithCounter: Button {

    var timerCounter1stDigit = SKSpriteNode(imageNamed: "Digit0")
    var timerCounter2ndDigit = SKSpriteNode(imageNamed: "Digit0")
    var digitSize = CGSize()
    
    func createTimerCounter(){
        
        timerCounter1stDigit.isHidden = true
        addChild(timerCounter1stDigit)
        
        timerCounter2ndDigit.isHidden = true
        addChild(timerCounter2ndDigit)
        digitSize = CGSize(width: timerCounter1stDigit.size.width / 6, height: timerCounter1stDigit.size.height / 6)

    }
    
    func updateTimerCounter(count: String){
        let symbols = count
        //print(count)
        
        let screenSize: CGRect = UIScreen.main.bounds
        var digitXBase: CGFloat = 0.0//screenSize.width/2//frame.midX)!//(scene?.size.width)! / 4//position.x + size.width/2  //CGPoint(x: size.width / 2, y: size.height / 2)
        if let GameScene = scene as? GameScene{
            digitXBase = GameScene.frame.midX - position.x//plane.position.x - position.x
        }
        let digitY = screenSize.height - position.y//4 * 3 + counter1stDigit.size.height / 16 //position.y - size.height/2 + counter1stDigit.size.height / 16
        timerCounter1stDigit.size = digitSize
        timerCounter1stDigit.zPosition = 8
        timerCounter1stDigit.position = CGPoint(x: digitXBase, y: digitY)
        timerCounter1stDigit.isHidden = false
        
        timerCounter2ndDigit.size = digitSize
        timerCounter2ndDigit.zPosition = 3
        timerCounter2ndDigit.position = CGPoint(x: digitXBase  + timerCounter1stDigit.size.width, y: digitY)
        timerCounter2ndDigit.isHidden = false
        
        
        timerCounter1stDigit.isHidden = true
        timerCounter2ndDigit.isHidden = true
        
        
        
        switch symbols.characters.count {
        case 1:
            timerCounter1stDigit.isHidden = false
            timerCounter1stDigit.texture = SKTexture(imageNamed: "0" + symbols[0])
            break
        case 2:
            timerCounter1stDigit.isHidden = false
            timerCounter1stDigit.texture = SKTexture(imageNamed: "0" + symbols[0])
            timerCounter2ndDigit.isHidden = false
            timerCounter2ndDigit.texture = SKTexture(imageNamed: "0" + symbols[1])
            break
        default:
            break
        }
    }
}
