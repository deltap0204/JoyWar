//
//  Gradient.swift
//  FlyPlane
//
//  Created by Dexter on 22/04/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

public enum GradientDirection {
    case Up
    case Left
    case UpLeft
    case UpRight
}

public extension SKTexture {
    convenience init(size: CGSize, endColor: CIColor, startColor: CIColor, direction: GradientDirection = .Up) {
        
        let context = CIContext(options: nil)
        let filter = CIFilter(name: "CILinearGradient")
        
        var startVector: CIVector
        var endVector: CIVector
        
        filter!.setDefaults()
        
        switch direction {
        case .Up:
            startVector = CIVector(x: size.width * 0.5, y: 0)
            endVector = CIVector(x: size.width * 0.5, y: size.height)
        case .Left:
            startVector = CIVector(x: size.width, y: size.height * 0.5)
            endVector = CIVector(x: 0, y: size.height * 0.5)
        case .UpLeft:
            startVector = CIVector(x: size.width, y: 0)
            endVector = CIVector(x: 0, y: size.height)
        case .UpRight:
            startVector = CIVector(x: 0, y: 0)
            endVector = CIVector(x: size.width, y: size.height)
        }
        
        filter!.setValue(startVector, forKey: "inputPoint0")
        filter!.setValue(endVector, forKey: "inputPoint1")
        filter!.setValue(endColor, forKey: "inputColor0")
        filter!.setValue(startColor, forKey: "inputColor1")
        
        let gradientImage = context.createCGImage(filter!.outputImage!, fromRect: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        self.init(CGImage: gradientImage)
    }
}
