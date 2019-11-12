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
    
    case def(Candies)
    
    func name() -> String {
        switch self {
            case .def(.biscuit):
                return "Biscuit"
            case .def(.chew):
                return "Chew"
            case .def(.chocolate):
                return "Chocolate"
            case .def(.dairy):
                return "Dairy"
            case .def(.gem):
                return "Gem"
            case .def(.jelly):
                return "Jelly"
            case .def(.spiral):
                return "Spiral"
            case .def(.sugar):
                return "Sugar"
        }
    }
}

enum CandyDollars {
    
    case def(Candies)
    
    func dollar() -> Int {
        switch self {
        case .def(.biscuit):
            return 4
        case .def(.chew):
            return 1
        case .def(.chocolate):
            return 4
        case .def(.dairy):
            return 6
        case .def(.gem):
            return 2
        case .def(.jelly):
            return 4
        case .def(.spiral):
            return 8
        case .def(.sugar):
            return 7
        }
    }
}

enum CandyType {
    
    case def(String)
    
    func Candy() -> Candies {
        switch self {
        case .def("Biscuit"):
            return Candies.biscuit
        case .def("Chew"):
            return Candies.chew
        case .def("Chocolate"):
            return Candies.chocolate
        case .def("Dairy"):
            return Candies.dairy
        case .def("Gem"):
            return Candies.gem
        case .def("Jelly"):
            return Candies.jelly
        case .def("Spiral"):
            return Candies.spiral
        case .def("Sugar"):
            return Candies.sugar
        default:
            return Candies.biscuit
        }
    }
}

class Candy: SKSpriteNode {
    
    var candyTexture = SKTexture(image: #imageLiteral(resourceName: "Biscuit"))
    var candyType = String()
    
    init(candy: Candies) {
        candyType = CandyTypes.def(candy).name()
        candyTexture = SKTexture(imageNamed: candyType)
        
        super.init(texture: candyTexture, color: UIColor(), size: CGSize(width: candyTexture.size().width / 16, height: candyTexture.size().height / 16))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func beginAnimation() {
        let MoveUp = SKAction.moveTo(y: position.y + 7.0, duration: 0.7)
        let MoveDown = SKAction.moveTo(y: position.y - 7.0, duration: 0.7)
        
        let random = arc4random_uniform(2) + 1
        
        let moveUpAndDown = (random == 1) ? SKAction.repeatForever(SKAction.sequence([MoveUp, MoveDown])) : SKAction.repeatForever(SKAction.sequence([MoveDown, MoveUp]))
        
        run(moveUpAndDown)
    }
    
}
