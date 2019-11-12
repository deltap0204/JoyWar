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
    
    var button = SKTexture(imageNamed: "BannerButton")
    
    init(type: String) {
        super.init(texture: button, color: UIColor(), size: CGSize(width: button.size().width / 2, height: button.size().height / 1.1))
        
        addChildNodeWith(type)
        
        zPosition = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addChildNodeWith(type: String) {
        
        var text = ""
        
        if (type == "RemoveAds") {
            text = "Remove Ads"
        } else if (type == "HighScore") {
            text = "High Score:"
        }
        
        let label = SKLabelNode(fontNamed:"Chalkduster")
        label.text = text
        label.fontSize = 20
        label.position = CGPoint(x:CGRectGetMidX(self.frame) + 6.0, y:CGRectGetMidY(self.frame) - 61.0)
        label.zRotation = CGFloat(M_PI_2)
        
        self.addChild(label)
        
    }
}