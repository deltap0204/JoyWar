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
    let balloon = SKTexture(imageNamed: "RedBaloon")
    
    init() {
        super.init(texture: balloon, color: UIColor(), size: CGSize(width: balloon.size().width, height: balloon.size().height))
        zPosition = 1
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveTo(yPoint : CGFloat?){
        if let destinationY = yPoint{
            //run(SKAction.moveBy(x: 0, y: destinationY, duration: 3))
            run(SKAction.moveTo(y: destinationY, duration: 0.5))
            
        }
        else{ delay(1, closure: {
            if let scene = self.parent as? GameScene{
                self.moveTo(yPoint: scene.queueOfPathForBaloon.dequeue())
            }
            
        })
            
        }
    }
}
