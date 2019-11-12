//
//  IceStick.swift
//  FlyPlane
//
//  Created by Dexter on 25/07/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class IceStick: SKSpriteNode {
    let iceStick = SKTexture(imageNamed: "IceCream")
    
    init() {
        super.init(texture: iceStick, color: UIColor(), size: CGSize(width: iceStick.size().width / 2.5, height: iceStick.size().height / 2.5))
        zPosition = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}