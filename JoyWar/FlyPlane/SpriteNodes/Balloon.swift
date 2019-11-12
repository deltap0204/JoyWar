//
//  Balloon.swift
//  FlyPlane
//
//  Created by Dexter on 25/07/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Balloon: SKSpriteNode {
    let balloon = SKTexture(imageNamed: "Balloon")
    
    init() {
        super.init(texture: balloon, color: UIColor(), size: CGSize(width: balloon.size().width / 5, height: balloon.size().height / 5))
        zPosition = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}