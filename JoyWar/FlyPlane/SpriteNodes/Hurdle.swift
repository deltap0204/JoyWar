//
//  Stick.swift
//  FlyPlane
//
//  Created by Dexter on 24/04/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Hurdle : SKSpriteNode {
    
    let hurdleAtTop = SKTexture(imageNamed: "HurdleInverse")
    let hurdleAtBottom = SKTexture(imageNamed: "Hurdle")
    
    var isHurdleInversed = Bool()
    
    var isAnimating = Bool()
    
    init(isUpsideDown: Bool) {
        
        super.init(texture: isUpsideDown ? hurdleAtTop : hurdleAtBottom, color: UIColor(), size: CGSize(width: hurdleAtTop.size().width, height: hurdleAtTop.size().height))
        
        isHurdleInversed = isUpsideDown
        
        zPosition = 0
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}