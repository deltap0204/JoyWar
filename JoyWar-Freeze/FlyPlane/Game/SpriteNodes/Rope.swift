//
//  Rope.swift
//  Game
//
//  Created by Developer on 24.05.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit


class Rope: SKNode{
    var positionOnStartNode = CGPoint()
    var startNode = SKNode()
    var attachedObject: SKNode?
    var ropeParts: Array<SKSpriteNode>?
    //var ropeLenght: Int
    
    override init() {
        super.init()
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func setAttachmentPoint(point: CGPoint, node: SKNode){
        positionOnStartNode = point
        startNode = node
    }
    
    func attachObject(object: SKNode){
        attachedObject = object
    }
    
    func setRopeLenght(ropeLenght: Int){
        if(ropeParts != nil ){
            ropeParts?.removeAll()
            ropeParts = nil
        }
        
        let firstNode = SKSpriteNode(imageNamed: "rope_ring")
        firstNode.position = positionOnStartNode
        ropeParts = Array<SKSpriteNode>(repeating:firstNode, count:ropeLenght)
        firstNode.physicsBody = SKPhysicsBody(circleOfRadius: firstNode.size.width)
        firstNode.physicsBody?.allowsRotation = true
        scene?.addChild(firstNode)
        
        for i in 1..<ropeLenght{
            let bufNode = SKSpriteNode(imageNamed: "rope_ring")
            bufNode.position = CGPoint(x: firstNode.position.x, y: firstNode.position.y - (CGFloat(Float(i)) * bufNode.size.height))
            bufNode.physicsBody = SKPhysicsBody(circleOfRadius: firstNode.size.width)
            bufNode.physicsBody?.allowsRotation = true
            
            bufNode.physicsBody?.collisionBitMask = Categories.pathFinder.rawValue
            
            scene?.addChild(bufNode)
            ropeParts?[i] = bufNode
        }
        if(attachedObject != nil){
            let object = attachedObject
            let previous = ropeParts?.last
            object?.position = CGPoint(x: (previous?.position.x)!, y: (previous?.frame)!.maxY)
            object?.physicsBody = SKPhysicsBody(circleOfRadius: (object?.frame.size.height)!/2)
            object?.physicsBody?.collisionBitMask = Categories.world.rawValue
            object?.physicsBody?.categoryBitMask = Categories.plane.rawValue
            object?.physicsBody?.contactTestBitMask = Categories.score.rawValue | Categories.dollar.rawValue | Categories.candyToDollar.rawValue | Categories.superPower.rawValue
            
            object?.physicsBody!.isDynamic = true
            object?.physicsBody!.allowsRotation = false
            object?.physicsBody!.affectedByGravity = true
            
            
            
            
            
            ropeParts?.append(object as! SKSpriteNode)
            if !(object is Plane){
                scene?.addChild(object!)}
        }
        
        
        ropePhysics()
        }
    func ropeLenght() ->Int?{
        return ropeParts?.count
    }
    
    func ropePhysics(){
        var nodeA = startNode
        var nodeB = ropeParts?[0]
        
        let physicsJointPin = SKPhysicsJointPin.joint(withBodyA: nodeA.physicsBody!, bodyB: (nodeB?.physicsBody)!, anchor: positionOnStartNode)
        

        scene?.physicsWorld.add(physicsJointPin)
        
        for i in 1..<(ropeParts?.count)! {
            nodeA = (ropeParts?[i-1])!
            nodeB = (ropeParts?[i])!
            var joint = SKPhysicsJointPin()
            if i<(ropeParts?.count)! - 1 {
                joint = SKPhysicsJointPin.joint(withBodyA: nodeA.physicsBody!, bodyB: (nodeB?.physicsBody)!, anchor: CGPoint(x: nodeA.frame.midX, y: (nodeB?.frame.midY)!))}
            else{
                joint = SKPhysicsJointPin.joint(withBodyA: nodeA.physicsBody!, bodyB: (nodeB?.physicsBody)!, anchor: CGPoint(x: nodeA.frame.midX, y: (nodeB?.frame.midY)!))
            }
            scene?.physicsWorld.add(joint)
        
        
        }
        
        
    
    }
    
    


}
