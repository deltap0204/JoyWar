//
//  RocketChanger.swift
//  Game
//
//  Created by Developer on 26.04.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class RocketChanger: Button {

    init() {
        let texture = SKTexture(image: #imageLiteral(resourceName: "Asset 1"))
        super.init(texture: texture, color: UIColor(), size: CGSize(width: texture.size().width/5, height: texture.size().height/5))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func beginBubbleAnimation() {
        let scale1By1 = SKAction.scale(to: 1.0, duration: 0.20)
        let scale3By4 = SKAction.scale(to: 0.9, duration: 0.10)
        let scale1By3 = SKAction.scale(to: 1.0, duration: 0.10)
        let scale1By2 = SKAction.scale(to: 0.8, duration: 0.10)
        let wait = SKAction.wait(forDuration: 1.0)
        let scaleSequence =  SKAction.repeatForever(SKAction.sequence([scale3By4, scale1By2, scale1By3, scale3By4, scale1By1, wait]))
        run(scaleSequence)
    }
}
