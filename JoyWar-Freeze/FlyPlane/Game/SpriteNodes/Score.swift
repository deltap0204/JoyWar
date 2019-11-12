//
//  Score.swift
//  FlyPlane
//
//  Created by Dexter on 30/04/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Score: SKSpriteNode {
    
    var score1stDigit = SKSpriteNode(imageNamed: "00")
    var score2ndDigit = SKSpriteNode(imageNamed: "01")
    var score3rdDigit = SKSpriteNode(imageNamed: "02")
    
    var isHighScore = Bool()
    
    var isSingleDigitScore = Bool()
    var isDoubleDigitScore = Bool()
    var isTripleDigitScore = Bool()
    
    init() {
        super.init(texture: nil, color: UIColor(), size: CGSize(width: score1stDigit.size.width / 1.5, height: score1stDigit.size.height / 1.5))
        
        score1stDigit.size = CGSize(width: score1stDigit.size.width / 1.5, height: score1stDigit.size.width / 1.5)
        score1stDigit.position = CGPoint(x: 0, y: 0.0)
        score1stDigit.isHidden = true
        addChild(score1stDigit)
        
        score2ndDigit.size = CGSize(width: score2ndDigit.size.width / 1.5, height: score2ndDigit.size.width / 1.5)
        score2ndDigit.position = CGPoint(x: score1stDigit.position.x + score2ndDigit.size.width / 1.5, y: 0)
        score2ndDigit.isHidden = true
        addChild(score2ndDigit)
        
        score3rdDigit.size = CGSize(width: score3rdDigit.size.width / 1.5, height: score3rdDigit.size.width / 1.5)
        score3rdDigit.position = CGPoint(x: score2ndDigit.position.x + score3rdDigit.size.width / 1.5, y: 0)
        score3rdDigit.isHidden = true
        addChild(score3rdDigit)
        
        updateScoresCount()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateScoresCount() {
        let scoresInNumberOfDigits:String = isHighScore ? "\(getHighScoreFromGameData())" : "\(GameScore)"//"\(getScoreFromGameData())"
        
        switch(scoresInNumberOfDigits.characters.count) {
        case 1:
            isSingleDigitScore = true
            isDoubleDigitScore = false
            isTripleDigitScore = false
            score3rdDigit.isHidden = false
            score3rdDigit.texture = SKTexture(imageNamed: "0" + scoresInNumberOfDigits)
            break
        case 2:
            isSingleDigitScore = false
            isDoubleDigitScore = true
            isTripleDigitScore = false
            score3rdDigit.isHidden = false
            score2ndDigit.isHidden = false
            score3rdDigit.texture = SKTexture(imageNamed: "0" + scoresInNumberOfDigits[1])
            score2ndDigit.texture = SKTexture(imageNamed: "0" + scoresInNumberOfDigits[0])
            break
        case 3:
            isSingleDigitScore = false
            isDoubleDigitScore = false
            isTripleDigitScore = true
            score3rdDigit.isHidden = false
            score2ndDigit.isHidden = false
            score1stDigit.isHidden = false
            score3rdDigit.texture = SKTexture(imageNamed: "0" + scoresInNumberOfDigits[2])
            score2ndDigit.texture = SKTexture(imageNamed: "0" + scoresInNumberOfDigits[1])
            score1stDigit.texture = SKTexture(imageNamed: "0" + scoresInNumberOfDigits[0])
            break
            
        default:
            break
        }
        
    }
}
