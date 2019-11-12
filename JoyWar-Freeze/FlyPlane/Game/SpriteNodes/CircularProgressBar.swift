//
//  CircularProgressBar.swift
//  Game
//
//  Created by Daniel Slupskiy on 06.04.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import Foundation
import SpriteKit

public class ProgressNode : SKShapeNode {
    
    
    // MARK: Constants
    
    struct Constants {
        static let radius : CGFloat          = 32
        static let color : SKColor           = SKColor.darkGray
        static let backgroundColor : SKColor = SKColor.lightGray
        static let width : CGFloat           = 2.0
        static let progress : CGFloat        = 0.0
        static let startAngle : CGFloat      = CGFloat(Double.pi)
        static let actionKey         = "_progressNodeCountdownActionKey"
    }
    
    
    // MARK: Properties

    public var radius: CGFloat = ProgressNode.Constants.radius {
        didSet {
            self.updateProgress(node: self.timeNode, progress: self.progress)
        }
    }
    
    public var color: SKColor = ProgressNode.Constants.color {
        didSet {
            self.timeNode.strokeColor = self.color
        }
    }
    
    public var backgroundColor: SKColor = ProgressNode.Constants.backgroundColor {
        didSet {
            self.strokeColor = self.backgroundColor
        }
    }
    
    public var width: CGFloat = ProgressNode.Constants.width {
        didSet {
            self.timeNode.lineWidth = self.width
            self.lineWidth          = self.width
        }
    }
    
    public var progress: CGFloat = ProgressNode.Constants.progress {
        didSet {
            self.updateProgress(node: self.timeNode, progress: self.progress)
        }
    }
    
    public var startAngle: CGFloat = ProgressNode.Constants.startAngle {
        didSet {
            self.updateProgress(node: self.timeNode, progress: self.progress)
        }
    }
    
    private let timeNode = SKShapeNode()
    
    
    // MARK: Lifecycle
    
    public init(radius: CGFloat,
                color: SKColor = ProgressNode.Constants.color,
                backgroundColor: SKColor = ProgressNode.Constants.backgroundColor,
                width: CGFloat = ProgressNode.Constants.width,
                progress: CGFloat = ProgressNode.Constants.progress) {
        
        self.radius          = radius
        self.color           = color
        self.backgroundColor = backgroundColor
        self.width           = width
        self.progress        = progress
        
        super.init()
        
        self._init()
    }
    
    override init() {
        super.init()
        
        self._init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self._init()
    }
    
    private func _init() {
        self.timeNode.lineWidth   = self.width
        self.timeNode.strokeColor = self.color
        self.timeNode.zPosition   = 10
        self.timeNode.position    = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        self.addChild(self.timeNode)
        self.updateProgress(node: self.timeNode, progress: self.progress)
        
        self.lineWidth   = self.width
        self.strokeColor = self.backgroundColor
        self.zPosition   = self.timeNode.zPosition
        
        self.updateProgress(node: self)
    }
    
    private func updateProgress(node: SKShapeNode, progress: CGFloat = 0.0) {
        let progress   = 1.0 - progress
        _ = CGFloat(.pi / 2.0)
        let endAngle   = self.startAngle + progress*CGFloat(2.0 * .pi)
        node.path      = UIBezierPath(arcCenter: CGPoint.zero,
                                      radius: self.radius,
                                      startAngle: self.startAngle,
                                      endAngle: endAngle,
                                      clockwise: true).cgPath
    }
    
    
    // MARK: API
   
    public func countdown(time: TimeInterval = 1.0, completionHandler: (() -> Void)?) {
        self.countdown(time: time, progressHandler: nil, completionHandler: completionHandler)
    }
    
    public func countdown(time: TimeInterval = 1.0, progressHandler: (() -> Void)?, completionHandler: (() -> Void)?) {
        self.stopCountdown()
        
        self.run(SKAction.customAction(withDuration: time, actionBlock: {(node: SKNode!, elapsedTime: CGFloat) -> Void in
            self.progress = elapsedTime / CGFloat(time)
            
            if let cb = progressHandler {
                DispatchQueue.main.async(execute: {
                    cb()
                })
            }
            
            if self.progress == 1.0 {
                if let cb = completionHandler {
                    DispatchQueue.main.async(execute: {
                        cb()
                    })
                }
            }
        }), withKey: ProgressNode.Constants.actionKey)
    }
    
    public func stopCountdown() {
        self.removeAction(forKey: ProgressNode.Constants.actionKey)
    }
}
