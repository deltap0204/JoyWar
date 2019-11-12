//
//  JoyStick.swift
//  FlyPlane
//
//  Created by Dexter on 25/07/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class JoyStick: SKSpriteNode {
    let joyStick = SKTexture(imageNamed: "CandyStick")
    
    init() {
        super.init(texture: joyStick, color: UIColor(), size: CGSize(width: joyStick.size().width / 2, height: joyStick.size().height / 2))
        zPosition = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}