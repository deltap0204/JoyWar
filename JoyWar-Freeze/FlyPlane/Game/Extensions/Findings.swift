//
//  Findings.swift
//  FlyPlane
//
//  Created by Dexter on 29/04/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation

/*

func createHurdle() {
let bottomHurdleTexture = SKTexture(imageNamed: "Stick")
bottomHurdleTexture.filteringMode = .Nearest

let topHurdleTexture = SKTexture(imageNamed: "Stick")
topHurdleTexture.filteringMode = .Nearest

let hurdlePair = SKNode()
hurdlePair.position = CGPointMake( self.frame.size.width + bottomHurdleTexture.size().width * 2, 0 )
hurdlePair.zPosition = 0

let bottomHurdlePositionY = CGFloat(arc4random()) % CGFloat(size.height / 3)
let hurdleAtBottom = SKSpriteNode(texture: bottomHurdleTexture)
hurdleAtBottom.size = CGSize(width: hurdleAtBottom.size.width, height: 390.0)
hurdleAtBottom.position = CGPointMake(0, bottomHurdlePositionY)
hurdleAtBottom.physicsBody = SKPhysicsBody(rectangleOfSize:hurdleAtBottom.size)
hurdleAtBottom.physicsBody?.dynamic = false;
hurdlePair.addChild(hurdleAtBottom)

//        let hurdleCandy = HurdleCandy()
//        hurdleCandy.position = CGPoint(x: hurdleAtBottom.position.x, y: hurdleAtBottom.position.y + hurdleAtBottom.size.height / 2)
//        hurdlePair.addChild(hurdleCandy)

let gap:CGFloat = 200.0 + (200.0 * 1/4)
let topHurdlePositionY = bottomHurdlePositionY + hurdleAtBottom.size.height + gap
let hurdleAtTop = SKSpriteNode(texture: topHurdleTexture)
hurdleAtTop.size = CGSize(width: hurdleAtTop.size.width, height: 390.0)
hurdleAtTop.position = CGPointMake(0, topHurdlePositionY)
hurdleAtTop.physicsBody = SKPhysicsBody(rectangleOfSize:hurdleAtTop.size)
hurdleAtTop.physicsBody?.dynamic = false
hurdlePair.addChild(hurdleAtTop)

//        let hurdleCandyAtTop = HurdleCandy()
//        hurdleCandyAtTop.position = CGPoint(x: hurdleAtTop.position.x, y: hurdleAtTop.position.y - hurdleAtTop.size.height / 2)
//        hurdlePair.addChild(hurdleCandyAtTop)

let distanceToMove = size.width + 2 * bottomHurdleTexture.size().width;
let moveHurdle = SKAction.moveByX(-distanceToMove, y: 0, duration: Double(0.01 * distanceToMove))
let removeHurdle = SKAction.removeFromParent()
moveHurdleAndRemove = SKAction.sequence([moveHurdle, removeHurdle])

hurdlePair.runAction(moveHurdleAndRemove)
hurdles.addChild(hurdlePair)
}

func moveHurdles() {
let spawn = SKAction.performSelector("createHurdles", onTarget: self)
let delay = SKAction.waitForDuration(2.3)
let spawnThenDelay = SKAction.sequence([spawn, delay])
let spawnThenDelayForever = SKAction.repeatActionForever(spawnThenDelay)
runAction(spawnThenDelayForever)

}

*/
