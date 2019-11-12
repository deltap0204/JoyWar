//
//  Candy.swift
//  FlyPlane
//
//  Created by Dexter on 09/05/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

enum CandyTypes {
    
    case Def(Candies)
    
    func name() -> String {
        switch self {
            case .Def(.Biscuit):
                return "Biscuit"
            case .Def(.Chew):
                return "Chew"
            case .Def(.Chocolate):
                return "Chocolate"
            case .Def(.Dairy):
                return "Dairy"
            case .Def(.Gem):
                return "Gem"
            case .Def(.Jelly):
                return "Jelly"
            case .Def(.Spiral):
                return "Spiral"
            case .Def(.Sugar):
                return "Sugar"
        }
    }
}

enum CandyDollars {
    
    case Def(Candies)
    
    func dollar() -> Int {
        switch self {
        case .Def(.Biscuit):
            return 4
        case .Def(.Chew):
            return 1
        case .Def(.Chocolate):
            return 4
        case .Def(.Dairy):
            return 6
        case .Def(.Gem):
            return 2
        case .Def(.Jelly):
            return 4
        case .Def(.Spiral):
            return 8
        case .Def(.Sugar):
            return 7
        }
    }
}

enum CandyType {
    
    case Def(String)
    
    func Candy() -> Candies {
        switch self {
        case .Def("Biscuit"):
            return Candies.Biscuit
        case .Def("Chew"):
            return Candies.Chew
        case .Def("Chocolate"):
            return Candies.Chocolate
        case .Def("Dairy"):
            return Candies.Dairy
        case .Def("Gem"):
            return Candies.Gem
        case .Def("Jelly"):
            return Candies.Jelly
        case .Def("Spiral"):
            return Candies.Spiral
        case .Def("Sugar"):
            return Candies.Sugar
        default:
            return Candies.Biscuit
        }
    }
}

class Candy: SKSpriteNode {
    
    var candyTexture = SKTexture(imageNamed: "Biscuit")
    var candyType = String()
    
    init(candy: Candies) {
        candyType = CandyTypes.Def(candy).name()
        candyTexture = SKTexture(imageNamed: candyType)
        
        super.init(texture: candyTexture, color: UIColor(), size: CGSize(width: candyTexture.size().width / 16, height: candyTexture.size().height / 16))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func beginAnimation() {
        let MoveUp = SKAction.moveToY(position.y + 7.0, duration: 0.7)
        let MoveDown = SKAction.moveToY(position.y - 7.0, duration: 0.7)
        
        let random = arc4random_uniform(2) + 1
        
        let moveUpAndDown = (random == 1) ? SKAction.repeatActionForever(SKAction.sequence([MoveUp, MoveDown])) : SKAction.repeatActionForever(SKAction.sequence([MoveDown, MoveUp]))
        
        runAction(moveUpAndDown)
    }
    
}