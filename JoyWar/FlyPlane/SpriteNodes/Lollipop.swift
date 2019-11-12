//
//  Lollipop.swift
//  FlyPlane
//
//  Created by Dexter on 24/04/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Lollipop : SKSpriteNode {
    
    let lollipop = SKTexture(imageNamed: "Lollipop")
    
    var isAnimating = Bool()
    
    init() {
        
        super.init(texture: lollipop, color: UIColor(), size: CGSize(width: lollipop.size().width - (lollipop.size().width * (1 / 1.6)) , height: lollipop.size().height - (lollipop.size().height * (1 / 1.6))))
        
        zPosition = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func beginAnimation() {
        
        if !isAnimating {
            let rotateAction = SKAction.rotateByAngle(CGFloat(M_PI / 4.0), duration: 1.5)
            runAction(SKAction.repeatActionForever(rotateAction))
        }
        
    }
    
}