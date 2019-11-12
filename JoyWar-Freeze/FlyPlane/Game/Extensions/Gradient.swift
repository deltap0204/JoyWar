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
    case up
    case left
    case upLeft
    case upRight
}

public extension SKTexture {
    convenience init(size: CGSize, endColor: CIColor, startColor: CIColor, direction: GradientDirection = .up) {
        
        let context = CIContext(options: nil)
        
        var startVector: CIVector
        var endVector: CIVector
        
        guard let filter = CIFilter(name: "CILinearGradient") else {
            self.init()
            return
        }
        filter.setDefaults()
        
        switch direction {
        case .up:
            startVector = CIVector(x: size.width * 0.5, y: 0)
            endVector = CIVector(x: size.width * 0.5, y: size.height)
        case .left:
            startVector = CIVector(x: size.width, y: size.height * 0.5)
            endVector = CIVector(x: 0, y: size.height * 0.5)
        case .upLeft:
            startVector = CIVector(x: size.width, y: 0)
            endVector = CIVector(x: 0, y: size.height)
        case .upRight:
            startVector = CIVector(x: 0, y: 0)
            endVector = CIVector(x: size.width, y: size.height)
        }
        
        filter.setValue(startVector, forKey: "inputPoint0")
        filter.setValue(endVector, forKey: "inputPoint1")
        filter.setValue(endColor, forKey: "inputColor0")
        filter.setValue(startColor, forKey: "inputColor1")
        
        let gradientImage = context.createCGImage(filter.outputImage!, from: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        if let gradientImage = gradientImage {
            self.init(cgImage: gradientImage)
        } else {
            self.init()
        }
    }
}
