//
//  BannerButton.swift
//  FlyPlane
//
//  Created by Dexter on 19/05/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import SpriteKit

class BannerButton: SKSpriteNode {
    
    var button = SKTexture(image: #imageLiteral(resourceName: "RemoveAds"))
    
    init(type: String) {
        let sizeMultiplier = CGFloat(0.15)
        super.init(texture: button, color: UIColor(), size: CGSize(width: button.size().width * sizeMultiplier,
                                                                   height: button.size().height * sizeMultiplier))
        
        addChildNodeWith(type)
        
        zPosition = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addChildNodeWith(_ type: String) {
        
        guard type == "HighScore" else {
            return
        }
        
        var text = ""
        let label = SKLabelNode(fontNamed:"Chalkduster")
        label.fontSize = 20
        label.position = CGPoint(x:self.frame.midX + 6.0, y:self.frame.midY - 61.0)
        label.zRotation = CGFloat(Double.pi/2)
        text = "High Score:"
        self.addChild(label)
    }
}
