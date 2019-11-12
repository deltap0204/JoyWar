//
//  Play.swift
//  FlyPlane
//
//  Created by Dexter on 05/05/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class Play: SKSpriteNode {
    
    let play = SKTexture(imageNamed: "Play")
    
    init() {
        super.init(texture: play, color: UIColor(), size: CGSize(width: play.size().width / 1.5, height: play.size().height / 1.5))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func beginAnimation() {
        let scale1By1 = SKAction.scaleTo(1.0, duration: 0.1)
        let scale3By4 = SKAction.scaleTo(0.90, duration: 0.1)
        let scale1By2 = SKAction.scaleTo(0.75, duration: 0.1)
        let scaleSequence = SKAction.sequence([scale3By4, scale1By2, scale3By4, scale1By1])
        runAction(scaleSequence)
    }
    
    func beginAlphaAnimation() {
        let alpha3By4 = SKAction.fadeAlphaTo(0.7, duration: 0.1)
        let alpha1By2 = SKAction.fadeAlphaTo(0.4, duration: 0.1)
        let alpha1By1 = SKAction.fadeAlphaTo(0.0, duration: 0.1)
        let alphaSequence = SKAction.sequence([alpha3By4, alpha1By2, alpha1By1])
        runAction(alphaSequence)
    }
}