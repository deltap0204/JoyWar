//
//  InAppPurchase.swift
//  FlyPlane
//
//  Created by Dexter on 11/06/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import SpriteKit

class InAppPurchase: SKSpriteNode {
    
    let store = SKTexture(imageNamed: "InAppPurchase")
    let progressBar = ProgressBar()
    
    let score = Score()
    let highScore = Score()
    
    init() {
        super.init(texture: store, color: UIColor(), size: CGSize(width: store.size().width, height: store.size().height))
        userInteractionEnabled = true
        zPosition = 1
        
        progressBar.name = "progressBar"
        progressBar.size = CGSize(width: progressBar.size.width, height: progressBar.size.height)
        progressBar.position = CGPoint(x: size.width / 2.5, y: size.height / 3.0)
        addChild(progressBar)
        
        let back = Button(imageNamed: "Back")
        back.name = "back"
        back.size = CGSize(width: back.size.width, height: back.size.height)
        back.position = CGPoint(x: -(back.size.width * 2.05), y: -(back.size.height * 4.85))
        back.anchorPoint = CGPoint(x: 1.0, y: 1.0)
        back.zPosition = 1
        addChild(back)
        
        let point99 = Button(imageNamed: "Point99")
        point99.name = "Point99"
        point99.position = CGPoint(x: size.width / 4.2, y: (size.height) / 5.2)
        addChild(point99)
        
        let twoPoint99 = Button(imageNamed: "2Point99")
        twoPoint99.name = "2Point99"
        twoPoint99.position = CGPoint(x: size.width / 4.2, y: (size.height) / 13.2)
        addChild(twoPoint99)
        
        let fivePoint99 = Button(imageNamed: "5Point99")
        fivePoint99.name = "5Point99"
        fivePoint99.position = CGPoint(x: size.width / 4.2, y: -(size.height) / 27.3)
        addChild(fivePoint99)
        
        let nineteenPoint99 = Button(imageNamed: "19Point99")
        nineteenPoint99.name = "19Point99"
        nineteenPoint99.position = CGPoint(x: size.width / 4.2, y: -(size.height) / 6.5)
        addChild(nineteenPoint99)
        
        let fiftyNinePoint99 = Button(imageNamed: "59Point99")
        fiftyNinePoint99.name = "59Point99"
        fiftyNinePoint99.position = CGPoint(x: size.width / 4.2, y: -(size.height) / 3.7)
        addChild(fiftyNinePoint99)
        
        let nintyNinePoint99 = Button(imageNamed: "99Point99")
        nintyNinePoint99.name = "99Point99"
        nintyNinePoint99.position = CGPoint(x: size.width / 4.2, y: -(size.height) / 2.6)
        addChild(nintyNinePoint99)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        let scale0By1 = SKAction.scaleTo(0.0, duration: 0.0)
        let scale1By2 = SKAction.scaleTo(0.61, duration: 0.2)
        let scaleSequence = SKAction.sequence([scale0By1, scale1By2])
        
        completionHandler(action: scaleSequence)
    }
    
    func hideAnimation(completionHandler: CompletionHandler) {
        let scale0By1 = SKAction.scaleTo(0.0, duration: 0.1)
        let scaleSequence = SKAction.sequence([scale0By1])
        
        completionHandler(action: scaleSequence)
    }
}