//
//  GameScene.swift
//  FlyPlane
//
//  Created by Dexter on 22/04/16.
//  Copyright (c) 2016 Studio2Entertainment. All rights reserved.
//

import SpriteKit
import StoreKit

enum Categories: UInt32 {
    case Plane = 1      // 1 << 0       // (2^ 0) * 1 = 1
    case World = 2      // 1 << 1       // (2^ 1) * 1 = 2
    case Hurdle = 4     // 1 << 2       // (2^ 2) * 1 = 4
    case Score = 8      // 1 << 3       // (2^ 3) * 1 = 8
    case Dollar = 16    // 1 << 4       // (2^ 4) * 1 = 16
    case CandyToDollar = 32 // 1 << 5   // (2^ 5) * 1 = 32
}

enum AdditionalHurdlePositions: UInt32 {
    case Top
    case Middle
    case Bottom
    
    static let _count: AdditionalHurdlePositions.RawValue = {
        var maxValue: UInt32 = 0
        while let _ = AdditionalHurdlePositions(rawValue: ++maxValue) { }
        return maxValue
    }()
    
    static func randomPosition() -> AdditionalHurdlePositions {
        let randomPosition = arc4random_uniform(_count)
        return AdditionalHurdlePositions(rawValue: randomPosition)!
    }
}

enum AdditionalHurdles: UInt32 {
    case Bomb
    case IceStick
    case JoyStick
    case Bubble
    case Gift
    
    static let _count: AdditionalHurdles.RawValue = {
        var maxValue: UInt32 = 0
        while let _ = AdditionalHurdles(rawValue: ++maxValue) { }
        return maxValue
    }()
    
    static func randomAdditionalHurdle() -> AdditionalHurdles {
        let randomAdditionalHurdle = arc4random_uniform(_count)
        return AdditionalHurdles(rawValue: randomAdditionalHurdle)!
    }
}

enum Candies: UInt32 {
    case Biscuit
    case Chew
    case Chocolate
    case Dairy
    case Gem
    case Jelly
    case Spiral
    case Sugar
    
    static let _count: Candies.RawValue = {
        var maxValue: UInt32 = 0
        while let _ = Candies(rawValue: ++maxValue) { }
        return maxValue
    }()
    
    static func randomCandy() -> Candies {
        // pick and return a new value
        let rand = arc4random_uniform(_count)
        return Candies(rawValue: rand)!
    }
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var protocolDelegate : PresentGameScene?
    
    let plane = Plane()
    let ground = Ground()
    let road = Road()
    let mountain = Mountain()
    
    let skyLimit = SKNode()
    
    let animatingNode = SKNode()
    let additionalAnimatingNode = SKNode()
    var isAnimating = Bool()
    
    let hurdles = SKNode()
    let hurdle = SKTexture(imageNamed: "Hurdle")
    
    var resumedHurdle = SKNode()
    var moveHurdleAndRemove = SKAction()
    var endlessHurdles = SKAction()
    
    let additionalHurdles = SKNode()
    
    var resumedAdditionalHurdle = SKNode()
    var moveAdditionalHurdleAndRemove = SKAction()
    var endlessAdditionalHurdles = SKAction()
    
    var isHurdlesAddedToAnimatingNode = Bool()
    var isAdditionalHurdlesAddedToAdditionalAnimatingNode = Bool()
    
    let dollarWallet = DollarWallet()
    let purchasedDollarsWallet = PurchasedDollars()
    
    var scoreWallet = Score()
    
    let saveMe = SaveMe()
    let gameOver = GameOver()
    let inAppPurchase = InAppPurchase()
    
    var candyToDollars = CandyToDollars()
    var candyType = String()
    
    var flag = Bool()
    var isTheGamePaused = Bool()
    var isTheGameResumed = Bool()
    
    override func didMoveToView(view: SKView) {

        subscribeToStoreManagerDelegate()
        configureGameResuming()
        
        if isTheGamePaused == true {
            self.userInteractionEnabled = false
            self.createAnimatingNode()
            self.createSky()
            self.createGround()
            self.createRoad()
            self.createMountain()
            delay(1.3, closure: { () -> () in
                self.createPlane()
                self.userInteractionEnabled = true
                self.createHurdles()
                self.createDollarWallet()
                self.createPurchasedDollars()
                self.createScoreWallet()
                self.createGameOver()
                self.createInAppPurchase()
                self.createSaveMe()
                self.moveAndCreateEndlessHurdles()
                self.moveAndCreateEndlessAdditionalHurdles()
                self.createPhysics()
                self.isTheGameResumed = true
            })
        } else {
            createAnimatingNode()
            createSky()
            createPlane()
            createGround()
            createRoad()
            createMountain()
            createHurdles()
            createDollarWallet()
            createPurchasedDollars()
            createScoreWallet()
            createGameOver()
            createInAppPurchase()
            createSaveMe()
            moveAndCreateEndlessHurdles()
            moveAndCreateEndlessAdditionalHurdles()
            createPhysics()
        }
    }
    
    func createAnimatingNode() {
        addChild(animatingNode)
        addChild(additionalAnimatingNode)
    }
    
    func createSky() {
        let topColor = CIColor(color: UIColor(red: 13.0 / 255.0, green: 179.0 / 255.0, blue: 249.0 / 255.0, alpha: 1.0))
        let bottomColor = CIColor(color: UIColor(red: 233.0 / 255.0, green: 255.0 / 255.0, blue: 253.0 / 255.0, alpha: 1.0))
        
        let skyTexture = SKTexture(size: CGSize(width: size.width, height: size.height), endColor: bottomColor, startColor: topColor)
        skyTexture.filteringMode = .Nearest
        
        let sky = SKSpriteNode(texture: skyTexture)
        sky.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame))
        sky.size = size
        sky.zPosition = 0
        
        animatingNode.addChild(sky)
        
        skyLimit.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRect(x: 0.0, y: ground.size.height + 5.0, width: frame.width, height: frame.height - (ground.size.height + 5.0)))
        skyLimit.physicsBody?.friction = 0.0
        skyLimit.physicsBody?.categoryBitMask = Categories.World.rawValue
        addChild(skyLimit)
    }
    
    func createPlane() {
        plane.removeFromParent()
        plane.position = CGPoint(x: size.width / 2, y: size.height / 2)
        plane.zPosition = 1
        
        plane.physicsBody = SKPhysicsBody(circleOfRadius: plane.size.width / 4)
        plane.physicsBody?.dynamic = true
        plane.physicsBody?.allowsRotation = false
        plane.physicsBody?.affectedByGravity = false
        
        plane.physicsBody?.categoryBitMask = Categories.Plane.rawValue
        plane.physicsBody?.collisionBitMask = Categories.World.rawValue | Categories.Hurdle.rawValue
        plane.physicsBody?.contactTestBitMask = Categories.Score.rawValue | Categories.World.rawValue | Categories.Hurdle.rawValue | Categories.Dollar.rawValue | Categories.CandyToDollar.rawValue
        
        plane.alpha = 0.0
        
        plane.beginAlphaAnimation(true)
        plane.beginAnimation()
        plane.bubble.beginExpandAnimation()
        addChild(plane)
    }
    
    func createGround() {
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: ground.size)
        ground.physicsBody?.categoryBitMask = Categories.World.rawValue
        ground.physicsBody?.dynamic = false
        
        animatingNode.addChild(ground)
    }
    
    func createRoad() {
        road.position = CGPoint(x: ground.position.x, y: ground.position.y + road.size.height - 10.0)
        road.physicsBody = SKPhysicsBody(rectangleOfSize: road.size)
        road.physicsBody?.categoryBitMask = Categories.World.rawValue
        road.physicsBody?.dynamic = false
        
        animatingNode.addChild(road)
    }
    
    func createMountain() {
        mountain.position = CGPoint(x: road.position.x, y: road.position.y + mountain.size.height / 2)
        animatingNode.addChild(mountain)
    }
    
    func createPhysics() {
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -5.5)
        physicsWorld.contactDelegate = self
    }
    
    func subscribeToStoreManagerDelegate() {
        StoreManager.sharedInstance.delegate = self
    }
    
    func configureGameResuming() {
        if isTheGamePaused {
            self.isTheGameResumed = true
            self.runAction(SKAction.runBlock({ () in self.createHurdle() }))
        }
    }
    
    func makePlaneJump() {
        
        if plane.physicsBody?.affectedByGravity == false {
            plane.physicsBody?.affectedByGravity = true
        }
        
        plane.physicsBody?.velocity = CGVector(dx: 0.0, dy: 0.0)
        plane.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 60.0))
    }
    
    func createAdditionalHurdles() -> Void {
        
        if !isAdditionalHurdlesAddedToAdditionalAnimatingNode {
            additionalAnimatingNode.addChild(additionalHurdles)
            isAdditionalHurdlesAddedToAdditionalAnimatingNode = true
        }
        
        let additionalHurdlePair = SKNode()
        additionalHurdlePair.name = "additionalHurdlePair"
        additionalHurdlePair.position = CGPointMake(self.frame.size.width, 0)
        additionalHurdlePair.zPosition = 0
        
        let lollipop = Lollipop()
        
        for index in 1 ..< 5 {
            
            let additionalHurdle = AdditionalHurdles.randomAdditionalHurdle()
            
            if additionalHurdle == AdditionalHurdles.IceStick || additionalHurdle == AdditionalHurdles.JoyStick || additionalHurdle == AdditionalHurdles.Gift {
                //TODO: Add these to the bottom of the screen
                
                switch additionalHurdle {
                case .IceStick:
                    let iceCream = IceStick()
                    
                    iceCream.name = "iceStick"
                    iceCream.position = CGPointMake(CGFloat(CGFloat(index) * lollipop.size.width * 4), ground.size.height + (ground.size.height * 0.85))
                    iceCream.physicsBody = SKPhysicsBody(rectangleOfSize:iceCream.size)
                    iceCream.physicsBody?.dynamic = false;
                    iceCream.physicsBody?.categoryBitMask = Categories.Hurdle.rawValue
                    
                    additionalHurdlePair.addChild(iceCream)
                    
                    break
                case .JoyStick:
                    let joyStick = JoyStick()
                    
                    joyStick.name = "joyStick"
                    joyStick.position = CGPointMake(CGFloat(CGFloat(index) * lollipop.size.width * 4), ground.size.height + (ground.size.height * 0.75))
                    joyStick.physicsBody = SKPhysicsBody(rectangleOfSize:joyStick.size)
                    joyStick.physicsBody?.dynamic = false;
                    joyStick.physicsBody?.categoryBitMask = Categories.Hurdle.rawValue
                    
                    additionalHurdlePair.addChild(joyStick)
                    
                    break
                case .Gift:
                    
                    break
                default:
                    break
                }
                
            } else {
                
                switch additionalHurdle {
                case .Bomb:
                    
                    let bomb = Bomb()
                    let bombPosition = AdditionalHurdlePositions.randomPosition()
                    bomb.name = "bomb"
                    bomb.physicsBody = SKPhysicsBody(rectangleOfSize: bomb.size)
                    bomb.physicsBody?.dynamic = false
                    bomb.physicsBody?.categoryBitMask = Categories.Hurdle.rawValue
                    bomb.everlastingFuseAnimation()
                    
                    additionalHurdlePair.addChild(bomb)
                    
                    switch bombPosition {
                    case .Bottom:
                        bomb.position = CGPointMake(CGFloat(CGFloat(index) * lollipop.size.width * 4), ground.size.height + (bomb.size.height / 2))
                        break
                    case .Middle:
                        bomb.position = CGPointMake(CGFloat(CGFloat(index) * lollipop.size.width * 4), size.height / 2)
                        break
                    case .Top:
                        bomb.position = CGPointMake(CGFloat(CGFloat(index) * lollipop.size.width * 4), size.height - (bomb.size.height / 2))
                        break
                    }
                    
                    break
                case .Bubble:
                    break
                default:
                    break
                }
                
            }
        }
        
        additionalHurdlePair.removeFromParent()
        additionalHurdlePair.runAction(moveAdditionalHurdleAndRemove)
        
        additionalHurdles.addChild(additionalHurdlePair)
    }
    
    func createHurdles() {
        
        if !isHurdlesAddedToAnimatingNode {
            animatingNode.addChild(hurdles)
            isHurdlesAddedToAnimatingNode = true
        }
        
        let hurdlePair = SKNode()
        hurdlePair.name = "hurdlePair"
        hurdlePair.position = CGPointMake(self.frame.size.width, 0)
        hurdlePair.zPosition = 0
        
        let bottomHurdlePositionY = CGFloat(arc4random()) % CGFloat(size.height / 3)
        
        let hurdleAtBottom = Hurdle(isUpsideDown: false)
        hurdleAtBottom.name = "hurdleAtBottom"
        hurdleAtBottom.position = CGPointMake(0, bottomHurdlePositionY)
        hurdleAtBottom.physicsBody = SKPhysicsBody(rectangleOfSize:hurdleAtBottom.size)
        hurdleAtBottom.physicsBody?.dynamic = false;
        hurdleAtBottom.physicsBody?.categoryBitMask = Categories.Hurdle.rawValue
        hurdlePair.addChild(hurdleAtBottom)
        
        let lollipopAtBottom = Lollipop()
        lollipopAtBottom.name = "lollipopAtBottom"
        lollipopAtBottom.position = CGPoint(x: hurdleAtBottom.position.x, y: hurdleAtBottom.position.y + hurdleAtBottom.size.height / 2 - lollipopAtBottom.size.width / 2)
        lollipopAtBottom.physicsBody = SKPhysicsBody(circleOfRadius: lollipopAtBottom.size.width / 2)
        lollipopAtBottom.physicsBody?.dynamic = false
        lollipopAtBottom.physicsBody?.categoryBitMask = Categories.Hurdle.rawValue
        hurdlePair.addChild(lollipopAtBottom)
        
        let gap:CGFloat = 200.0
        let topHurdlePositionY = bottomHurdlePositionY + hurdleAtBottom.size.height + gap
        
        let hurdleAtTop = Hurdle(isUpsideDown: true)
        hurdleAtTop.name = "hurdleAtTop"
        hurdleAtTop.position = CGPointMake(0, topHurdlePositionY)
        hurdleAtTop.physicsBody = SKPhysicsBody(rectangleOfSize:hurdleAtTop.size)
        hurdleAtTop.physicsBody?.dynamic = false
        hurdleAtTop.physicsBody?.categoryBitMask = Categories.Hurdle.rawValue
        hurdlePair.addChild(hurdleAtTop)
        
        let lollipopAtTop = Lollipop()
        lollipopAtTop.name = "lollipopAtTop"
        lollipopAtTop.position = CGPoint(x: hurdleAtTop.position.x, y: hurdleAtTop.position.y - hurdleAtTop.size.height / 2 + lollipopAtTop.size.width / 2)
        lollipopAtTop.physicsBody = SKPhysicsBody(circleOfRadius: lollipopAtTop.size.width / 2)
        lollipopAtTop.physicsBody?.dynamic = false
        lollipopAtTop.physicsBody?.categoryBitMask = Categories.Hurdle.rawValue
        hurdlePair.addChild(lollipopAtTop)
        
        let candy = Candy(candy: Candies.randomCandy())
        candy.position = CGPoint(x: 0.0, y: CGFloat(lollipopAtBottom.position.y) + (lollipopAtTop.size.height / 2) + (CGFloat(gap / 2)))
        candy.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: candy.size.width * 2, height: candy.size.height * 2))
        candy.physicsBody?.dynamic = false
        candy.physicsBody?.categoryBitMask = Categories.Dollar.rawValue
        candy.beginAnimation()
        hurdlePair.addChild(candy)

        let candyToDollars = CandyToDollars()
        candyToDollars.position = CGPoint(x: candy.position.x, y: candy.position.y + 50.0)
        candyToDollars.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: candy.size.width, height: candy.size.height + 50.0))
        candyToDollars.physicsBody?.dynamic = false
        candyToDollars.physicsBody?.categoryBitMask = Categories.CandyToDollar.rawValue
        hurdlePair.addChild(candyToDollars)
        
        let score = SKNode()
        score.position = CGPoint(x: hurdleAtBottom.size.width + plane.size.width / 5, y: CGRectGetMidY(frame))
        score.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: hurdleAtBottom.size.width, height: frame.height))
        score.physicsBody?.dynamic = false
        score.physicsBody?.categoryBitMask = Categories.Score.rawValue
        hurdlePair.addChild(score)
        
        hurdlePair.removeFromParent()
        hurdlePair.runAction(moveHurdleAndRemove)
        
        if animatingNode.speed > 0 {
            lollipopAtBottom.beginAnimation()
            lollipopAtTop.beginAnimation()
        }
        
        hurdles.addChild(hurdlePair)
        NSLog("Hurdle Speed", animatingNode.speed)
    }
    
    func createHurdle() {
        
        if !isHurdlesAddedToAnimatingNode {
            animatingNode.addChild(hurdles)
            isHurdlesAddedToAnimatingNode = true
        }
        
        let hurdlePair = SKNode()
        hurdlePair.name = "hurdlePair"
        hurdlePair.position = CGPointMake(self.frame.size.width, 0)
        hurdlePair.zPosition = 0
        
        let bottomHurdlePositionY = CGFloat(arc4random()) % CGFloat(size.height / 3)
        
        let hurdleAtBottom = Hurdle(isUpsideDown: false)
        hurdleAtBottom.name = "hurdleAtBottom"
        hurdleAtBottom.position = CGPointMake(0, bottomHurdlePositionY)
        hurdleAtBottom.physicsBody = SKPhysicsBody(rectangleOfSize:hurdleAtBottom.size)
        hurdleAtBottom.physicsBody?.dynamic = false;
        hurdleAtBottom.physicsBody?.categoryBitMask = Categories.Hurdle.rawValue
        hurdlePair.addChild(hurdleAtBottom)
        
        let lollipopAtBottom = Lollipop()
        lollipopAtBottom.name = "lollipopAtBottom"
        lollipopAtBottom.position = CGPoint(x: hurdleAtBottom.position.x, y: hurdleAtBottom.position.y + hurdleAtBottom.size.height / 2 - lollipopAtBottom.size.width / 2)
        lollipopAtBottom.physicsBody = SKPhysicsBody(circleOfRadius: lollipopAtBottom.size.width / 2)
        lollipopAtBottom.physicsBody?.dynamic = false
        lollipopAtBottom.physicsBody?.categoryBitMask = Categories.Hurdle.rawValue
        hurdlePair.addChild(lollipopAtBottom)
        
        let gap:CGFloat = 200.0
        let topHurdlePositionY = bottomHurdlePositionY + hurdleAtBottom.size.height + gap
        
        let hurdleAtTop = Hurdle(isUpsideDown: true)
        hurdleAtTop.name = "hurdleAtTop"
        hurdleAtTop.position = CGPointMake(0, topHurdlePositionY)
        hurdleAtTop.physicsBody = SKPhysicsBody(rectangleOfSize:hurdleAtTop.size)
        hurdleAtTop.physicsBody?.dynamic = false
        hurdleAtTop.physicsBody?.categoryBitMask = Categories.Hurdle.rawValue
        hurdlePair.addChild(hurdleAtTop)
        
        let lollipopAtTop = Lollipop()
        lollipopAtTop.name = "lollipopAtTop"
        lollipopAtTop.position = CGPoint(x: hurdleAtTop.position.x, y: hurdleAtTop.position.y - hurdleAtTop.size.height / 2 + lollipopAtTop.size.width / 2)
        lollipopAtTop.physicsBody = SKPhysicsBody(circleOfRadius: lollipopAtTop.size.width / 2)
        lollipopAtTop.physicsBody?.dynamic = false
        lollipopAtTop.physicsBody?.categoryBitMask = Categories.Hurdle.rawValue
        hurdlePair.addChild(lollipopAtTop)
        
        let candy = Candy(candy: Candies.randomCandy())
        candy.position = CGPoint(x: 0.0, y: CGFloat(lollipopAtBottom.position.y) + (lollipopAtTop.size.height / 2) + (CGFloat(gap / 2)))
        candy.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: candy.size.width * 2, height: candy.size.height * 2))
        candy.physicsBody?.dynamic = false
        candy.physicsBody?.categoryBitMask = Categories.Dollar.rawValue
        candy.beginAnimation()
        hurdlePair.addChild(candy)
        
        let candyToDollars = CandyToDollars()
        candyToDollars.position = CGPoint(x: candy.position.x, y: candy.position.y + 50.0)
        candyToDollars.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: candy.size.width, height: candy.size.height + 50.0))
        candyToDollars.physicsBody?.dynamic = false
        candyToDollars.physicsBody?.categoryBitMask = Categories.CandyToDollar.rawValue
        hurdlePair.addChild(candyToDollars)
        
        let score = SKNode()
        score.position = CGPoint(x: hurdleAtBottom.size.width + plane.size.width / 5, y: CGRectGetMidY(frame))
        score.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: hurdleAtBottom.size.width, height: frame.height))
        score.physicsBody?.dynamic = false
        score.physicsBody?.categoryBitMask = Categories.Score.rawValue
        hurdlePair.addChild(score)
        
        hurdlePair.position = CGPoint(x: size.width / 2, y: -25.0)
        
        lollipopAtBottom.beginAnimation()
        lollipopAtTop.beginAnimation()
        
        let hurdleAtBottomAnimation = SKAction.moveToY(57.0, duration: 1.0)
        let lollipopAtBottomAnimation = SKAction.moveToY(209.8125, duration: 1.0)
        
        let hurdleAtTopPosition = size.height + hurdleAtTop.size.height / 2 - 104.0
        let lollipopAtTopPosition = hurdleAtTopPosition - 152.8125
        let hurdleAtTopAnimation = SKAction.moveToY(hurdleAtTopPosition, duration: 1.0)
        let lollipopAtTopAnimation = SKAction.moveToY(lollipopAtTopPosition, duration: 1.0)
        
        hurdleAtBottom.runAction(hurdleAtBottomAnimation)
        lollipopAtBottom.runAction(lollipopAtBottomAnimation)
        hurdleAtTop.runAction(hurdleAtTopAnimation)
        lollipopAtTop.runAction(lollipopAtTopAnimation)
        
        resumedHurdle = hurdlePair
        
        addChild(hurdlePair)
    }
    
    func animateHurdleAtBottom(hurdleAtBottom: SKNode) {
        let margin: CGFloat = 57.0
        let Y:CGFloat = hurdleAtBottom.position.y
        
        if margin > Y {
            
        }
        
    }
    
    func moveResumedHurdleAndRemove() -> SKAction {
        let distanceToMove = size.width / 2 + hurdle.size().width;
        let moveHurdle = SKAction.moveByX(-distanceToMove, y: 0, duration: Double(0.0038 * distanceToMove))
        let removeHurdle = SKAction.removeFromParent()
        return SKAction.sequence([moveHurdle, removeHurdle])
    }
    
    func moveAndCreateEndlessHurdles() {
        let distanceToMove = size.width
        let moveHurdle = SKAction.moveByX(-distanceToMove, y: 0, duration: Double(0.0038 * distanceToMove))
        let removeHurdle = SKAction.removeFromParent()
        moveHurdleAndRemove = SKAction.sequence([moveHurdle, removeHurdle])

        let createHurdle = SKAction.runBlock({ () in self.createHurdles() })
        let afterDelay = SKAction.waitForDuration(Double(0.0038 * distanceToMove))
        let createHurdleAfterDelay = SKAction.sequence([createHurdle, afterDelay])
        endlessHurdles = SKAction.repeatActionForever(createHurdleAfterDelay)
    }
    
    func moveAndCreateEndlessAdditionalHurdles() {
        let distanceToMove = size.width + size.width
        let moveHurdle = SKAction.moveByX(-distanceToMove, y: 0, duration: Double(0.0038 * distanceToMove))
        let removeHurdle = SKAction.removeFromParent()
        moveAdditionalHurdleAndRemove = SKAction.sequence([moveHurdle, removeHurdle])
        
        let createAdditionalHurdle = SKAction.runBlock({ () in self.createAdditionalHurdles() })
        let afterDelay = SKAction.waitForDuration(Double(0.0038 * distanceToMove))
        let createAdditionalHurdleAfterDelay = SKAction.sequence([createAdditionalHurdle, afterDelay])
        endlessAdditionalHurdles = SKAction.repeatActionForever(createAdditionalHurdleAfterDelay)
    }
    
    func beginEndlessHurdles() {
        self.runAction(self.endlessHurdles)
    }
    
    func beginEndlessAdditionalHurdles() {
        self.runAction(self.endlessAdditionalHurdles)
    }
    
    func createDollarWallet() {
        dollarWallet.name = "DollarWallet"
        dollarWallet.position = CGPoint(x: size.width / 2.5, y: size.height / 1.05)
        dollarWallet.updateDollarsCount()
        addChild(dollarWallet)
    }
    
    func createPurchasedDollars() {
        purchasedDollarsWallet.name = "PurchasedDollars"
        purchasedDollarsWallet.position = CGPoint(x: dollarWallet.position.x, y: dollarWallet.position.y - 100.0)
        purchasedDollarsWallet.hidden = true
        addChild(purchasedDollarsWallet)
    }
    
    func createScoreWallet() {
        if (isTheGameResumed || isTheGamePaused) {
            //nothing to do here!
        } else {
            initializeScoreToGameData(0)
        }
        scoreWallet.position = CGPoint(x: size.width / 1.55, y: size.height / 1.05)
        scoreWallet.isHighScore = false
        scoreWallet.updateScoresCount()
        addChild(scoreWallet)
    }
    
    func createGameOver() {
        gameOver.setScale(0.0)
        gameOver.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(gameOver)
    }
    
    func createInAppPurchase() {
        inAppPurchase.setScale(0.0)
        inAppPurchase.position = CGPoint(x: size.width / 2, y: size.height / 2)
        inAppPurchase.progressBar.hidden = true
        inAppPurchase.progressBar.beginAnimation()
        addChild(inAppPurchase)
    }
    
    func createCandyToDollars() {
        candyToDollars = CandyToDollars()
        candyToDollars.position = CGPoint(x: size.width / 1.5, y: size.height / 1.5)
        addChild(candyToDollars)
    }
    
    func createSaveMe() {
        saveMe.setScale(0.0)
        saveMe.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(saveMe)
    }
    
    func tiltConstraints(min: CGFloat, max: CGFloat, value: CGFloat) -> CGFloat {
        
        if value > max {
            return max
        } else if value < min {
            return min
        } else {
            return value
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        if isAnimating == false {
            if isTheGamePaused == true {
                if isTheGameResumed == true {
                    isTheGamePaused = false
                    isTheGameResumed = false
                    isAnimating = true
                    resumedHurdle.runAction(moveResumedHurdleAndRemove())
                    mountain.beginAnimation()
                    ground.beginAnimation()
                    road.beginAnimation()
                    beginEndlessHurdles()
                    
                    delay(0.7, closure: {
                        self.beginEndlessAdditionalHurdles()
                    })
                }
            } else {
                if flag == true {
                    let touch:UITouch = touches.first!
                    let positionInScene = touch.locationInNode(self)
                    let node = self.nodeAtPoint(positionInScene)
                    
                    var nodeName = String()
                    
                    if node.name == nil {
                        nodeName = "empty"
                    } else {
                        nodeName = node.name!
                    }
                    
                    //  Play audio sound effects on user tap!
                    AudioPlayer.stop()
                    AudioPlayer.playJumpOrButtonMusicFX()
                    
                    switch(nodeName) {
                    case "plus", "DollarWallet", "dollar":
                        if !self.isAnimating {
                            if self.inAppPurchase.xScale > 0.0 || self.saveMe.xScale > 0.0 || self.gameOver.xScale > 0.0{
                                return
                            }
                            self.dollarWallet.beginAnimation()
                            delay(0.3, closure: { () -> () in
                                self.inAppPurchase.beginAnimation({ (action) -> Void in
                                    self.inAppPurchase.runAction(action)
                                })
                            })
                        }
                        self.flag = false
                        return
                    case "back":
                        let back = node as! Button
                        back.beginAnimation()
                        delay(0.2, closure: {
                            self.inAppPurchase.hideAnimation({ (action) -> Void in
                                self.inAppPurchase.runAction(action, completion: { () -> Void in
                                })
                            })
                        })
                        self.flag = false
                        return
                    case "Point99":
                        let buyPoint99 = node as! Button
                        inAppPurchase.progressBar.hidden = false
                        buyPoint99.beginAnimation()
                        delay(0.3, closure: {
                            for (_, product) in StoreManager.sharedInstance.loadedProducts.enumerate() {
                                if product.productIdentifier == "com.Studio2Entertainment.FlyPlane.HundredDollars"{
                                    StoreManager.sharedInstance.purchaseProduct(product)
                                }
                            }
                        })
                        self.flag = false
                        break
                    case "2Point99":
                        let buy2Point99 = node as! Button
                        inAppPurchase.progressBar.hidden = false
                        buy2Point99.beginAnimation()
                        delay(0.3, closure: {
                            for (_, product) in StoreManager.sharedInstance.loadedProducts.enumerate() {
                                if product.productIdentifier == "com.Studio2Entertainment.FlyPlane.FiHundredDollars" {
                                    StoreManager.sharedInstance.purchaseProduct(product)
                                }
                            }
                        })
                        self.flag = false
                        break
                    case "5Point99":
                        let buy5Point99 = node as! Button
                        inAppPurchase.progressBar.hidden = false
                        buy5Point99.beginAnimation()
                        delay(0.3, closure: {
                            for (_, product) in StoreManager.sharedInstance.loadedProducts.enumerate() {
                                if product.productIdentifier == "com.Studio2Entertainment.FlyPlane.TwoThousandDollars" {
                                    StoreManager.sharedInstance.purchaseProduct(product)
                                }
                            }
                        })
                        self.flag = false
                        break
                    case "19Point99":
                        let buy19Point99 = node as! Button
                        inAppPurchase.progressBar.hidden = false
                        buy19Point99.beginAnimation()
                        delay(0.3, closure: {
                            for (_, product) in StoreManager.sharedInstance.loadedProducts.enumerate() {
                                if product.productIdentifier == "com.Studio2Entertainment.FlyPlane.FiveThousandDollars" {
                                    StoreManager.sharedInstance.purchaseProduct(product)
                                }
                            }
                        })
                        self.flag = false
                        break
                    case "59Point99":
                        let buy59Point99 = node as! Button
                        inAppPurchase.progressBar.hidden = false
                        buy59Point99.beginAnimation()
                        delay(0.3, closure: {
                            for (_, product) in StoreManager.sharedInstance.loadedProducts.enumerate() {
                                if product.productIdentifier == "com.Studio2Entertainment.FlyPlane.FiftyThousandDollars" {
                                    StoreManager.sharedInstance.purchaseProduct(product)
                                }
                            }
                        })
                        self.flag = false
                        break
                    case "99Point99":
                        let buy99Point99 = node as! Button
                        inAppPurchase.progressBar.hidden = true
                        buy99Point99.beginAnimation()
                        delay(0.3, closure: {
                            for (_, product) in StoreManager.sharedInstance.loadedProducts.enumerate() {
                                if product.productIdentifier == "com.Studio2Entertainment.FlyPlane.OneLakhDollars" {
                                    StoreManager.sharedInstance.purchaseProduct(product)
                                }
                            }
                        })
                        self.flag = false
                        break
                    default:
                        break
                    }
                }
                
                if self.inAppPurchase.xScale > 0.0 || self.gameOver.xScale > 0.0 || self.gameOver.xScale > 0.0 {
                    return
                }
                
                mountain.beginAnimation()
                ground.beginAnimation()
                road.beginAnimation()
                beginEndlessHurdles()
                
                delay(0.7, closure: {
                    self.beginEndlessAdditionalHurdles()
                })
                
                isAnimating = true
            }
        }
        
        if flag == true {
            
            let touch:UITouch = touches.first!
            let positionInScene = touch.locationInNode(self)
            let node = self.nodeAtPoint(positionInScene)
            
            var nodeName = String()
            
            if node.name == nil {
                nodeName = "empty"
            } else {
                nodeName = node.name!
            }
            
            let qualityOfServiceIdentifier = QOS_CLASS_BACKGROUND
            let backgroundQueue = dispatch_get_global_queue(qualityOfServiceIdentifier, 0)
            dispatch_async(backgroundQueue, {
                
                //  Play audio sound effects on user tap!
                AudioPlayer.stop()
                AudioPlayer.playJumpOrButtonMusicFX()
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                })
            })
            
            switch(nodeName) {
                case "buyDollars":
                    //TODO: Perform store purchase option
                    let dollarsFromGameData: NSInteger = getDollarsFromGameData()
                    let dollarsRequired: NSInteger = self.saveMe.dollarsRequiredForResumingGame
                    
                    if (dollarsFromGameData > dollarsRequired) {
                        self.saveMe.hideAnimation({ (action) -> Void in
                            self.saveMe.runAction(action, completion: { () -> Void in
                                
                                let dollarsBeforeDeduction = getDollarsFromGameData()
                                let dollarsAfterDeduction = dollarsBeforeDeduction - dollarsRequired
                                insertDollarsToGameData(dollarsAfterDeduction)
                                
                                self.protocolDelegate?.presentGameScene(true)
                            })
                        })
                    } else {
                        //TODO: Create Product
                        let requiredDollars = self.saveMe.dollarsRequiredForResumingGame
                        var requiredProduct = SKProduct()
                        
                        if requiredDollars == 100 {
                            requiredProduct = getProductForIdentifer("com.Studio2Entertainment.FlyPlane.HundredDollars")
                        } else if requiredDollars == 500 {
                            requiredProduct = getProductForIdentifer("com.Studio2Entertainment.FlyPlane.FiveHundredDollars")
                        } else if requiredDollars == 2000 {
                            requiredProduct = getProductForIdentifer("com.Studio2Entertainment.FlyPlane.TwoThousandDollars")
                        } else if requiredDollars == 5000 {
                            requiredProduct = getProductForIdentifer("com.Studio2Entertainment.FlyPlane.FiveThousandDollars")
                        } else if requiredDollars == 50000 {
                            requiredProduct = getProductForIdentifer("com.Studio2Entertainment.FlyPlane.FiftyThousandDollars")
                        } else if requiredDollars == 100000 {
                            requiredProduct = getProductForIdentifer("com.Studio2Entertainment.FlyPlane.OneLakhDollars")
                        }
                        
                        StoreManager.sharedInstance.purchaseProduct(requiredProduct)
                    }
                break
            case "close":
                self.updateScoreAndHighScoreToGameData()
                    self.saveMe.hideAnimation({ (action) -> Void in
                        self.saveMe.runAction(action, completion: { () -> Void in
                            self.gameOver.beginAnimation({ (action) -> Void in
                                self.gameOver.runAction(action, completion: { () -> Void in
                                })
                            })
                        })
                    })
                    break
                case "menuGameOver":
                    initializeScoreToGameData(0)
                    self.gameOver.hideAnimation({ (action) -> Void in
                        self.gameOver.runAction(action, completion: { () -> Void in
                            delay(0.2, closure: { () -> () in
                                self.protocolDelegate?.presentFrontScene()
                            })
                        })
                    })
                    break
                case "menuSaveMe":
                    self.saveMe.hideAnimationMenuTapped({ (action) -> Void in
                        self.saveMe.runAction(action, completion: { () -> Void in
                            self.protocolDelegate?.presentFrontScene()
                        })
                    })
                    break
                case "reload":
                    initializeScoreToGameData(0)
                    paused = false
                    self.gameOver.hideAnimation({ (action) -> Void in
                        self.gameOver.runAction(action, completion: { () -> Void in
                            delay(0.2, closure: { () -> () in
                                self.protocolDelegate?.presentGameScene(false)
                            })
                        })
                    })
                    break
                case "store":
                    //TODO: Perform store purchage option
                    self.gameOver.hideAnimation({ (action) -> Void in
                        self.gameOver.runAction(action, completion: { () -> Void in
                            self.inAppPurchase.beginAnimation({ (action) -> Void in
                                self.inAppPurchase.runAction(action, completion: { () -> Void in                                    
                                })
                            })
                        })
                    })
                    break
                case "Point99":
                    let buyPoint99 = node as! Button
                    buyPoint99.beginAnimation()
                    delay(0.3, closure: {
                        for (_, product) in StoreManager.sharedInstance.loadedProducts.enumerate() {
                            if product.productIdentifier == "com.Studio2Entertainment.FlyPlane.HundredDollars"{
                                StoreManager.sharedInstance.purchaseProduct(product)
                            }
                        }
                    })
                    break
                case "2Point99":
                    let buy2Point99 = node as! Button
                    buy2Point99.beginAnimation()
                    delay(0.3, closure: {
                        for (_, product) in StoreManager.sharedInstance.loadedProducts.enumerate() {
                            if product.productIdentifier == "com.Studio2Entertainment.FlyPlane.FiHundredDollars" {
                                StoreManager.sharedInstance.purchaseProduct(product)
                            }
                        }
                    })
                    break
                case "5Point99":
                    let buy5Point99 = node as! Button
                    buy5Point99.beginAnimation()
                    delay(0.3, closure: {
                        for (_, product) in StoreManager.sharedInstance.loadedProducts.enumerate() {
                            if product.productIdentifier == "com.Studio2Entertainment.FlyPlane.TwoThousandDollars" {
                                StoreManager.sharedInstance.purchaseProduct(product)
                            }
                        }
                    })
                    break
                case "19Point99":
                    let buy19Point99 = node as! Button
                    buy19Point99.beginAnimation()
                    delay(0.3, closure: {
                        for (_, product) in StoreManager.sharedInstance.loadedProducts.enumerate() {
                            if product.productIdentifier == "com.Studio2Entertainment.FlyPlane.FiveThousandDollars" {
                                StoreManager.sharedInstance.purchaseProduct(product)
                            }
                        }
                    })
                    break
                case "59Point99":
                    let buy59Point99 = node as! Button
                    buy59Point99.beginAnimation()
                    delay(0.3, closure: {
                        for (_, product) in StoreManager.sharedInstance.loadedProducts.enumerate() {
                            if product.productIdentifier == "com.Studio2Entertainment.FlyPlane.FiftyThousandDollars" {
                                StoreManager.sharedInstance.purchaseProduct(product)
                            }
                        }
                    })
                    break
                case "99Point99":
                    let buy99Point99 = node as! Button
                    buy99Point99.beginAnimation()
                    delay(0.3, closure: {
                        for (_, product) in StoreManager.sharedInstance.loadedProducts.enumerate() {
                            if product.productIdentifier == "com.Studio2Entertainment.FlyPlane.OneLakhDollars" {
                                StoreManager.sharedInstance.purchaseProduct(product)
                            }
                        }
                    })
                    break
                case "back":
                    let back = node as! Button
                    back.beginAnimation()
                    delay(0.2, closure: {
                        self.inAppPurchase.hideAnimation({ (action) -> Void in
                            self.inAppPurchase.runAction(action, completion: { () -> Void in
                                self.gameOver.beginAnimation({ (action) -> Void in
                                    self.gameOver.runAction(action)
                                })
                            })
                        })
                    })
                    break
                case "plus":
                    if !isAnimating {
                        if self.inAppPurchase.xScale > 0.0 || self.saveMe.xScale > 0.0 || self.gameOver.xScale > 0.0{
                            return
                        }
                            self.dollarWallet.beginAnimation()
                            delay(0.3, closure: { () -> () in
                                self.inAppPurchase.beginAnimation({ (action) -> Void in
                                    self.inAppPurchase.runAction(action)
                                })
                            })
                         
                    }
                    break
                default:
                    break
                }
        }
        
        if (flag == true) {
            flag = false
            return
        }
        
        makePlaneJump()
    }
    
    func getProductForIdentifer(productIdentifier: String) -> SKProduct {
        for (_, product) in StoreManager.sharedInstance.loadedProducts.enumerate() {
            if product.productIdentifier == productIdentifier {
                return product
            }
        }
        return SKProduct()
    }
   
    override func update(currentTime: CFTimeInterval) {
        if isAnimating {
            if animatingNode.speed > 0 {
                let zRotationValue: CGFloat = (self.plane.physicsBody!.velocity.dy) * (self.plane.physicsBody!.velocity.dx < 0 ? 0.005625 : 0.00125)
                self.plane.zRotation = self.tiltConstraints(-1, max: 0.5, value: zRotationValue)
            }
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        if animatingNode.speed > 0 {
            
            let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
            
            switch(contactMask) {
                
            case Categories.Plane.rawValue | Categories.Score.rawValue:
                updateScore()
                break
                
            case Categories.Plane.rawValue | Categories.World.rawValue:
                pauseGame()
                getScoreFromGameData()
                updateHighScoreToGameData(GameScore)
                break
                
            case Categories.Plane.rawValue | Categories.Hurdle.rawValue:
                pauseGame()
                //TODO: Shake Screen
                break
                
            case Categories.Dollar.rawValue | Categories.Plane.rawValue:
                let candy:Candy = contact.bodyA.node as! Candy
                self.candyType = candy.candyType
                candy.runAction(getCandyActionSequenceSequence(candy))
                candy.physicsBody = nil
                
                delay(0.5, closure:  {
                    self.dollarWallet.beginDollarAnimation()
                })
                break
                
            case Categories.CandyToDollar.rawValue | Categories.Plane.rawValue:
                let candyToDollar:CandyToDollars = contact.bodyA.node as! CandyToDollars
                
                let qualityOfServiceIdentifier = QOS_CLASS_BACKGROUND
                let backgroundQueue = dispatch_get_global_queue(qualityOfServiceIdentifier, 0)
                dispatch_async(backgroundQueue, {
                    
                    //  Play audio sound effects on user tap!
                    AudioPlayer.stop()
                    AudioPlayer.playCoinCollectionMusicFX()
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        candyToDollar.hidden = false
                        candyToDollar.dollar = CandyDollars.Def(CandyType.Def(self.candyType).Candy()).dollar() // Needs to be dynamic
                        candyToDollar.updateScoresCount()
                        candyToDollar.beginAnimation()
                        
                        updateDollarsToGameData(candyToDollar.dollar)
                        self.dollarWallet.updateDollarsCount()
                    })
                })
                
                break
                
            default:
                break
                
            }
        }
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        
    }
    
    func updateScore() {
        GameScore += 1
        initializeScoreToGameData(GameScore)
        self.scoreWallet.isHighScore = false
        self.scoreWallet.updateScoresCount()
    }
    
    func updateScoreAndHighScoreToGameData() {
        getScoreFromGameData()
        updateHighScoreToGameData(GameScore)
        GameHighScore = getHighScoreFromGameData()
        self.gameOver.score.isHighScore = false
        self.gameOver.score.updateScoresCount()
        self.gameOver.positionScore()
        self.gameOver.highScore.isHighScore = true
        self.gameOver.highScore.updateScoresCount()
        self.gameOver.positionHighScore()
    }
    
    func pauseGame() {
        let qualityOfServiceIdentifier = QOS_CLASS_BACKGROUND
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceIdentifier, 0)
        dispatch_async(backgroundQueue, {
            
            //  Play audio sound effects on user tap!
            AudioPlayer.stop()
            AudioPlayer.playGameOverMusicFX()
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let rotatePlane = SKAction.rotateByAngle(0.01, duration: 0.003)
                let stopPlane = SKAction.runBlock({ () in
                    self.plane.speed = 0
                })
                let slowDownPlane = SKAction.sequence([rotatePlane, stopPlane])
                self.plane.runAction(slowDownPlane)
                
                self.animatingNode.speed = 0
                
                delay(0.1, closure: {
                    
                    getScoreFromGameData()
                    let isScoreBelowFive = GameScore < 5
                    
                    if (isScoreBelowFive) {
                        self.gameOver.beginAnimation({ (action) -> Void in
                            self.gameOver.runAction(action, completion: { () -> Void in
                                self.updateScoreAndHighScoreToGameData()
                            })
                        })
                    } else {
                        self.saveMe.beginAnimation({ (action) -> Void in
                            self.saveMe.runAction(action, completion: { () -> Void in
                                self.updateScoreAndHighScoreToGameData()
                                self.saveMe.updateDollarsCount()
                            })
                        })
                    }
                })
            })
        })
    }
    
    func resumeGame() {
        self.scoreWallet.hidden = false
    }
    
    func drawCandyAnimationCurvePath(candy: SKNode) -> CGPathRef {
        // Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(candy.position.x, candy.position.y))
        bezierPath.addLineToPoint(CGPointMake(-125.0, 735.5))
        UIColor.blackColor().setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
        
        return bezierPath.CGPath
    }
    
    func getCandyActionSequenceSequence(coin: SKNode) -> SKAction {
        let path = drawCandyAnimationCurvePath(coin)
        
        let followPath = SKAction.followPath(path, asOffset: false, orientToPath: false, duration: 0.5)
        let remove = SKAction.removeFromParent()
        let fadeOut = SKAction.fadeOutWithDuration(0.5)
        
        let sequence = SKAction.sequence([followPath, remove])
        let animation = SKAction.group([fadeOut, sequence])
        
        return animation
    }
}

extension GameScene: StoreManagerDelegate {
    func updateWithProducts(products: [SKProduct]) { }
    
    func purchaseFailed(reason: String) {
        self.inAppPurchase.progressBar.hidden = true
        showAlert("Purcahse Failed", message: "Please try again!", buttonTitle: "Ok")
    }
    
    func refreshPurchaseStatus(purchasedDollars: Int) {
        
        self.inAppPurchase.progressBar.hidden = true
                
        self.inAppPurchase.hideAnimation({ (action) -> Void in
            self.inAppPurchase.runAction(action, completion: { () -> Void in
                if GameScore > 0 {
                    //Which means need to show the gameover popup!
                    self.gameOver.beginAnimation({ (action) in
                        self.gameOver.runAction(action, completion: {
                            self.purchasedDollarsWallet.updateDollarsCount(purchasedDollars)
                            self.purchasedDollarsWallet.hidden = false
                            self.purchasedDollarsWallet.beginAnimation({ (action) in
                                self.purchasedDollarsWallet.runAction(action)
                                delay(1.0, closure: {
                                    
                                    //  Play purchased coins added to the dollar wallet animation
                                    AudioPlayer.playCoinsAddedToWalletMusicFX()
                                    
                                    self.dollarWallet.beginDollarAnimation()
                                    delay(0.1, closure: {
                                        self.dollarWallet.beginDollarUpdateAnimation()
                                        delay(0.05, closure: {
                                            self.dollarWallet.updateDollarsCount()
                                            self.purchasedDollarsWallet.hidden = true
                                            self.purchasedDollarsWallet.fadeInAnimationBehindTheScene({ (action) in
                                                self.purchasedDollarsWallet.runAction(action)
                                            })
                                            self.purchasedDollarsWallet.position.y = self.purchasedDollarsWallet.position.y - 75.0
                                        })
                                    })
                                })
                            })
                        })
                    })
                } else {
                    self.purchasedDollarsWallet.updateDollarsCount(purchasedDollars)
                    self.purchasedDollarsWallet.hidden = false
                    self.purchasedDollarsWallet.beginAnimation({ (action) in
                        self.purchasedDollarsWallet.runAction(action)
                        delay(1.0, closure: {
                            
                            //  Play purchased coins added to the dollar wallet animation
                            AudioPlayer.playCoinsAddedToWalletMusicFX()
                            
                            self.dollarWallet.beginDollarAnimation()
                            delay(0.1, closure: {
                                self.dollarWallet.beginDollarUpdateAnimation()
                                delay(0.05, closure: {
                                    self.dollarWallet.updateDollarsCount()
                                    self.purchasedDollarsWallet.hidden = true
                                    self.purchasedDollarsWallet.fadeInAnimationBehindTheScene({ (action) in
                                        self.purchasedDollarsWallet.runAction(action)
                                    })
                                    self.purchasedDollarsWallet.position.y = self.purchasedDollarsWallet.position.y - 75.0
                                })
                            })
                        })
                    })
                }
            })
        })
    }
}
