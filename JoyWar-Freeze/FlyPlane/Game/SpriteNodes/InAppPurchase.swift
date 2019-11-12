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
    
    let store = SKTexture(imageNamed: "IAPStoreNew")    
    let score = Score()
    let highScore = Score()
    
    init() {
        super.init(texture: store, color: UIColor(), size: CGSize(width: store.size().width/2.3,
                                                                  height: store.size().height/2.3))
        isUserInteractionEnabled = true
        zPosition = 1
        
        let back = Button(imageNamed: "Close")
        back.name = "back"
        back.size = CGSize(width: back.size.width/4, height: back.size.height/4)
        back.position = CGPoint(x: size.height/2 - 110, y: size.width/2+40)
        back.anchorPoint = CGPoint(x: 1.0, y: 1.0)
        back.zPosition = 1
        addChild(back)
        
        let point99 = Button(imageNamed: "Point99-1")
        point99.name = "Point99"
        point99.position = CGPoint(x: size.width / 4.2, y: (size.height) / 4.3)
        addChild(point99)
        
        let twoPoint99 = Button(imageNamed: "2Point99")
        twoPoint99.name = "2Point99"
        twoPoint99.position = CGPoint(x: size.width / 4.2, y: (size.height) / 9.4)
        addChild(twoPoint99)
        
        let fivePoint99 = Button(imageNamed: "5Point99")
        fivePoint99.name = "5Point99"
        fivePoint99.position = CGPoint(x: size.width / 4.2, y: -(size.height) / 62)
        addChild(fivePoint99)
        
        let nineteenPoint99 = Button(imageNamed: "16Point99")
        nineteenPoint99.name = "19Point99"
        nineteenPoint99.position = CGPoint(x: size.width / 4.2, y: -(size.height) / 7.3)
        addChild(nineteenPoint99)
        
        let fiftyNinePoint99 = Button(imageNamed: "26Point99")
        fiftyNinePoint99.name = "59Point99"
        fiftyNinePoint99.position = CGPoint(x: size.width / 4.2, y: -(size.height) / 3.9)
        addChild(fiftyNinePoint99)
        
        let nintyNinePoint99 = Button(imageNamed: "49Point99")
        nintyNinePoint99.name = "99Point99"
        nintyNinePoint99.position = CGPoint(x: size.width / 4.2, y: -(size.height) / 2.6)
        addChild(nintyNinePoint99)
        
        
        
        point99.setScale(0.5)
        
        twoPoint99.setScale(0.5)
        
        fivePoint99.setScale(0.5)
        
        nineteenPoint99.setScale(0.5)
        
        fiftyNinePoint99.setScale(0.5)
        
        nintyNinePoint99.setScale(0.5)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    typealias CompletionHandler = (_ action: SKAction) -> Void
    
    func beginAnimation(_ completionHandler: CompletionHandler) {
        let scale0By1 = SKAction.scale(to: 0.0, duration: 0.0)
        let scale1By2 = SKAction.scale(to: 0.61, duration: 0.2)
        let scaleSequence = SKAction.sequence([scale0By1, scale1By2])
        
        completionHandler(scaleSequence)
    }
    
    func hideAnimation(_ completionHandler: CompletionHandler) {
        let scale0By1 = SKAction.scale(to: 0.0, duration: 0.1)
        let scaleSequence = SKAction.sequence([scale0By1])
        
        completionHandler(scaleSequence)
    }
}
