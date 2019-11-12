//
//  GameOver.swift
//  FlyPlane
//
//  Created by Dexter on 02/05/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import SpriteKit

class GameOver: SKSpriteNode {
    
    let gameOver = SKTexture(imageNamed: "GameOver-4")
    
    let menu = SKSpriteNode(imageNamed: "Menu")
    let reload = SKSpriteNode(imageNamed: "Reload")
    let store = SKSpriteNode(imageNamed: "Store")
    
    let score = Score()
    let highScore = Score()
    
    init() {
        super.init(texture: gameOver, color: UIColor(), size: CGSize(width: gameOver.size().width, height: gameOver.size().height))
        userInteractionEnabled = true
        zPosition = 1
        
        addChild(score)
        
        addChild(highScore)
        
        menu.name = "menuGameOver"
        menu.size = CGSize(width: menu.size.width, height: menu.size.height)
        menu.position = CGPoint(x: -(menu.size.width - menu.size.width * 0.08), y: -(menu.size.height * 2.85))
        menu.anchorPoint = CGPoint(x: 1.0, y: 1.0)
        menu.zPosition = 1
        addChild(menu)
        
        reload.name = "reload"
        reload.size = CGSize(width: reload.size.width, height: reload.size.height)
        reload.position = CGPoint(x: reload.size.width - (reload.size.width / 2.1), y: -(reload.size.height * 2.85))
        reload.anchorPoint = CGPoint(x: 1.0, y: 1.0)
        reload.zPosition = 1
        addChild(reload)
        
        store.name = "store"
        store.size = CGSize(width: store.size.width, height: store.size.height)
        store.position = CGPoint(x: store.size.width * 2.05, y: -(store.size.height * 2.85))
        store.anchorPoint = CGPoint(x: 1.0, y: 1.0)
        store.zPosition = 1
        addChild(store)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let gameScene = parent as! GameScene
        gameScene.flag = true
        gameScene.touchesBegan(touches, withEvent: event)
    }

    typealias CompletionHandler = (action: SKAction) -> Void
    
    func beginAnimation(completionHandler: CompletionHandler) {
        let scale0By1 = SKAction.scaleTo(0.0, duration: 0.0)
        let scale1By2 = SKAction.scaleTo(0.60, duration: 0.2)
        let scaleSequence = SKAction.sequence([scale0By1, scale1By2])
        
        completionHandler(action: scaleSequence)
    }
    
    func hideAnimation(completionHandler: CompletionHandler) {
        let scale0By1 = SKAction.scaleTo(0.0, duration: 0.1)
        let scaleSequence = SKAction.sequence([scale0By1])
        
        completionHandler(action: scaleSequence)
    }
    
    func positionScore() {
        var xPosition = CGFloat()
        if score.isSingleDigitScore {
            xPosition = -45.0
        }
        if score.isDoubleDigitScore {
            xPosition = -35.0
        }
        if score.isTripleDigitScore {
            xPosition = -25.0
        }
        score.position = CGPoint(x: xPosition, y: +75.0)
        
    }
    
    func positionHighScore() {
        var xPosition = CGFloat()
        if highScore.isSingleDigitScore {
            xPosition = -45.0
        }
        if highScore.isDoubleDigitScore {
            xPosition = -35.0
        }
        if highScore.isTripleDigitScore {
            xPosition = -25.0
        }
        highScore.position = CGPoint(x: xPosition, y: -61.0)
    }
}