//
//  UpControl.swift
//  Game
//
//  Created by Daniel Slupskiy on 27.03.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit


class HeightControl: Button {
    
    enum Direction {
        case up
        case down
    }
    
    // MARK: Properties
    let direction: Direction
    
    
    // MARK: Lifecycle
    
    init(withDirection direction: Direction) {
        let texture = SKTexture(image: #imageLiteral(resourceName: "GlossyArrow"))
        self.direction = direction
        super.init(texture: texture, color: UIColor(), size: CGSize(width: texture.size().width / 8, height: texture.size().height / 8))
        
        var rotation: SKAction
        switch direction {
        case .down:
            rotation = SKAction.rotate(byAngle: CGFloat(-Double.pi/2), duration: 0)
        case .up:
            rotation = SKAction.rotate(byAngle: CGFloat(Double.pi/2), duration: 0)
        }
        run(rotation)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

