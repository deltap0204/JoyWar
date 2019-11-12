//
//  Gift.swift
//  FlyPlane
//
//  Created by Dexter on 25/07/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Gift: SKSpriteNode {
    let gift = SKTexture(imageNamed: "Gift")
    
    init() {
        super.init(texture: gift, color: UIColor(), size: CGSize(width: gift.size().width / 5, height: gift.size().height / 5))
        zPosition = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
