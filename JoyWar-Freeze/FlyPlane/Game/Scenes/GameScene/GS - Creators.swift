//
//  GameScene - creators.swift
//  Game
//
//  Created by Daniel Slupskiy on 30.03.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func createControls() {
        
        guard upHeightControl.parent == nil else {
            return
        }
        
        downHeightControl.position.x = size.width/2
        downHeightControl.position.y = 100 - 50
        
        upHeightControl.position.x = size.width/2
        upHeightControl.position.y = 100 + 50
        
        upHeightControl.zPosition = 3
        downHeightControl.zPosition = 3
        
        addChild(upHeightControl)
        addChild(downHeightControl)
        
        ballonControl.position.x = size.width/3 - 7
        ballonControl.position.y = 75 + 50
        ballonControl.zPosition = 3
        
        addChild(ballonControl)
        
        pathFinderControl.position.x = size.width/3 - 7
        pathFinderControl.position.y =  50 
        pathFinderControl.zPosition = 3
        
        addChild(pathFinderControl)
        
        bubbleIndicator.position.x = pathFinderControl.position.x + 79
        bubbleIndicator.position.y = 100 - 50
        bubbleIndicator.zPosition = 3
        
        addChild(bubbleIndicator)
        
        rocketIndicator.position.x = size.width * 2/3
        rocketIndicator.position.y = 100 - 50
        rocketIndicator.zPosition = 3

        addChild(rocketIndicator)
        
        rocketChanger.position.x = size.width * 2/3.1
        rocketChanger.position.y = 90
        rocketChanger.zPosition = 3
        
        addChild(rocketChanger)
        
        shootingControl.position.x = rocketIndicator.position.x - 75
        shootingControl.position.y = 100 - 50
        shootingControl.zPosition = 3
        
        addChild(shootingControl)
    }
    
    func createAnimatingNode() {
        
        addChild(animatingNode)
        addChild(additionalAnimatingNode)
        
    }
    
    func createSky() {
        let topColor = CIColor(color: UIColor(red: 13.0 / 255.0, green: 179.0 / 255.0, blue: 249.0 / 255.0, alpha: 1.0))
        let bottomColor = CIColor(color: UIColor(red: 233.0 / 255.0, green: 255.0 / 255.0, blue: 253.0 / 255.0, alpha: 1.0))
        
        let skyTexture = SKTexture(size: CGSize(width: size.width, height: size.height), endColor: bottomColor, startColor: topColor)
        skyTexture.filteringMode = .nearest
        
        let sky = SKSpriteNode(texture: skyTexture)
        sky.position = CGPoint(x: frame.midX, y: frame.midY)
        sky.size = size
        sky.zPosition = -1
        
        animatingNode.addChild(sky)
        
        skyLimit.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0.0, y: ground.size.height + 5.0, width: frame.width, height: frame.height - (ground.size.height + 5.0)))
        skyLimit.physicsBody?.friction = 0.0
        skyLimit.physicsBody?.categoryBitMask = Categories.world.rawValue
        addChild(skyLimit)
    }
    
    func createPlane() {
        plane.removeFromParent()
        plane.position = CGPoint(x: size.width / 2, y: size.height / 2)
        
        plane.alpha = 0.0
        
        plane.beginAlphaAnimation(true)
        plane.beginAnimation()
        plane.bubble.beginExpandAnimation()
        plane.machineGunDelegate = shootingControl
        plane.rocketDelegate = rocketIndicator
        rocketIndicator.updateCounter(with: PlayersBackpack.rocketsCount[Plane.currentRocketType]!)
        
                
        addChild(plane)
        
        self.playSound(sound: audioFileNames.planeFlying)
    }
    
    func createBubbleSuperPower() -> Bubble {
        let bubble = Bubble()
        let multiplier = CGFloat(Int.random(range: ClosedRange(uncheckedBounds: (lower: 1, upper: 6))))
       

        bubble.position = CGPoint(x: frame.size.width*2/3, y: frame.size.height*multiplier/8)
        let moveTop = SKAction.moveTo(y: size.height+50, duration: 5)
        bubble.run(moveTop)
        
        return bubble
    }
    
    func createGround() {
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.categoryBitMask = Categories.world.rawValue
        ground.physicsBody?.isDynamic = false
        
        animatingNode.addChild(ground)
    }
    
    func createRoad() {
        road.position = CGPoint(x: ground.position.x, y: ground.position.y + road.size.height - 10.0)
        road.physicsBody = SKPhysicsBody(rectangleOf: road.size)
        road.physicsBody?.categoryBitMask = Categories.world.rawValue
        road.physicsBody?.isDynamic = false
        
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
    
    func createAdditionalHurdles() -> Void {
        
        guard !Enemy.isShown, !isTheGamePaused, (additionalAnimatingNode.speed>0) else { return }
        
        if !isAdditionalHurdlesAddedToAdditionalAnimatingNode {
            additionalAnimatingNode.addChild(additionalHurdles)
            isAdditionalHurdlesAddedToAdditionalAnimatingNode = true
        }
        
        let numberOfHurdlesToAdd = 3
        let step = self.size.width / CGFloat(hurdlesOccurenceFrequencyDivider * Double(numberOfHurdlesToAdd + 1))
        
        var hurdleNumber = 1
        var lastHurdleTypeRawValue = 0
        
        while(hurdleNumber < numberOfHurdlesToAdd){
            
            var newAdditionalHurdle : SKNode?
            nonLollipopHurdlesCount += 1
            nonStallHurdleCount += 1
            nonBubbleHurdleCount += 1
            
            var additionalTypesSet = AdditionalHurdles.allValues
            if hurdleNumber >= numberOfHurdlesToAdd - 1 {
                if let index = additionalTypesSet.index(of:.stall) {
                    additionalTypesSet.remove(at: index)
                }
            }
            if lastHurdleTypeRawValue == Int(AdditionalHurdles.iceCream.rawValue){
                if let index = additionalTypesSet.index(of:.iceCream) {
                    additionalTypesSet.remove(at: index)
                }
            }
            
            if plane.isBalloonEnabled {
                if let index = additionalTypesSet.index(of:.enemy) {
                    additionalTypesSet.remove(at: index)
                }

            }
            
            var newAdditionalHurdleType : AdditionalHurdles = .donuts
            
            if hurdleNumber != numberOfHurdlesToAdd-1 {
                newAdditionalHurdleType = AdditionalHurdles.randomAdditionalHurdle()
            } else {
                newAdditionalHurdleType = AdditionalHurdles.randomAdditionalHurdleWithoutDonut()
            }

            if nonBubbleHurdleCount > 25 {
                newAdditionalHurdleType = AdditionalHurdles.bubble
            }
            else if nonStallHurdleCount > 5 && hurdleNumber < numberOfHurdlesToAdd - 1 {
                newAdditionalHurdleType = AdditionalHurdles.stall
            }
            else if nonLollipopHurdlesCount > 3 {
                newAdditionalHurdleType = AdditionalHurdles.lollipop
            }

            
            let hurdleXPosition = self.size.width + CGFloat(hurdleNumber + 1) * (step)
            //print("HurdleXPosition \(hurdleXPosition)")
            
            let score = SKNode()
            score.position = CGPoint(x: 40, y: frame.midY)
            score.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: frame.height))
            score.physicsBody?.isDynamic = true
            score.physicsBody?.affectedByGravity = false
            score.physicsBody?.allowsRotation = false
            score.physicsBody?.categoryBitMask = Categories.score.rawValue
            
            score.physicsBody?.collisionBitMask = 0
            score.name = "additionalScore"
            
            
            
            switch newAdditionalHurdleType {
            case .iceStick:
                newAdditionalHurdle = IceStick()
                newAdditionalHurdle!.position = CGPoint(x: hurdleXPosition, y: ground.size.height + (ground.size.height * 0.85+50))
                valueInQueueFrom(additionalHurdle: newAdditionalHurdle)
                newAdditionalHurdle?.name = "iceStick"
                
                newAdditionalHurdle?.addChild(score)
                break
            case .joyStick:
                
                newAdditionalHurdle = JoyStick()
                newAdditionalHurdle!.position = CGPoint(x: hurdleXPosition, y: ground.size.height + (ground.size.height * 0.75))
                newAdditionalHurdle?.position.y -= 20
                valueInQueueFrom(additionalHurdle: newAdditionalHurdle)
                newAdditionalHurdle?.addChild(score)

                break
            case .gift:
                break
            case .lollipop:
                let randomTypeNumber = Int.random(range: ClosedRange(uncheckedBounds: (lower: 1, upper: 6)))
                let heightMultiplier = CGFloat(Int.random(range: ClosedRange(uncheckedBounds: (lower: 17, upper: 27))))/10
                newAdditionalHurdle = Lollipop(withTheme: LollipopTheme(rawValue: randomTypeNumber)!)
                newAdditionalHurdle!.position = CGPoint(x: hurdleXPosition, y: ground.size.height + (ground.size.height * heightMultiplier))
                nonLollipopHurdlesCount = 0

                valueInQueueFrom(additionalHurdle: newAdditionalHurdle)
                
                newAdditionalHurdle?.addChild(score)
                break
            case .donuts:
                    newAdditionalHurdle = createDonuts()
                    let multiplier = CGFloat(Int.random(range: ClosedRange(uncheckedBounds: (lower: 3, upper: 6))))
                    newAdditionalHurdle!.position = CGPoint(x: hurdleXPosition, y: frame.size.height*multiplier/8)
                    
//                    var positionOfY = newAdditionalHurdle!.position.y
//                    if positionOfY > frame.size.height/2 {
//                        positionOfY -= 100
//                    } else {
//                        positionOfY += 100
//                    }
//                    valueInQueueFrom(positionOfY: positionOfY)
                break
            case .bubble:
                let randomInt = Int.random(range: ClosedRange(uncheckedBounds: (lower: 1, upper: 10)))
                if randomInt == 7 || nonBubbleHurdleCount > 25{
                    newAdditionalHurdle = createBubbleSuperPower()
                    nonBubbleHurdleCount = 0
                }
                
                break
            case .enemy:
                let randomInt = Int.random(range: ClosedRange(uncheckedBounds: (lower: 1, upper: 3)))
                if randomInt == 2 && !Enemy.isShown{ createEnemy() }
                
                break
                
            case .iceCream:
                newAdditionalHurdle = IceCream()
                newAdditionalHurdle!.position = CGPoint(x: hurdleXPosition + 15, y: ground.size.height + 75)
                valueInQueueFrom(additionalHurdle: newAdditionalHurdle)
                newAdditionalHurdle?.addChild(score)
                (newAdditionalHurdle as! IceCream).beginAnimation()
            case .stall:
                nonStallHurdleCount = 0
                
                if let action = self.action(forKey: "endlessHurdles") {
                    
                    action.speed = 0
                    
                    let distanceToMove = size.width
                    delay(1.0, closure: {
                        action.speed = 1
                    })
                }
               
                let stall = Stall()
                
                let stallWidth = 200.0/1.5
                let stallHeight = 400.0
                
                let switcherValue = arc4random_uniform(22)
                
                switch switcherValue{
                case 2, 3:
                    let rocketPower = RocketPower(type: RocketType.type1)
                    rocketPower.upAndDownAnimation()
                    stall.addChild(rocketPower)
                    break
                case 6:
                    let rocketPower = RocketPower(type: RocketType.type2)
                    rocketPower.upAndDownAnimation()
                    stall.addChild(rocketPower)
                    break
                case 9:
                    let rocketPower = RocketPower(type: RocketType.type3)
                    rocketPower.upAndDownAnimation()
                    stall.addChild(rocketPower)
                    break
                case 12:
                    let rocketPower = RocketPower(type: RocketType.type4)
                    rocketPower.upAndDownAnimation()
                    stall.addChild(rocketPower)
                    break
                case 15:
                    let rocketPower = RocketPower(type: RocketType.type5)
                    rocketPower.upAndDownAnimation()
                    stall.addChild(rocketPower)
                    break
                case 16, 18:
                    let bubble = Bubble()
                    bubble.upAndDownAnimation()
                    bubble.position = CGPoint(x: 0, y: stallHeight/2 - 50)
                    stall.addChild(bubble)
                    break
                case 20, 21:
                    let bullets = Bullets(multiplierId: Int(arc4random_uniform(2)))
                    bullets.upAndDownAnimation()
                    bullets.position = CGPoint(x: 0, y: stallHeight/2 - 50)
                    stall.addChild(bullets)
                    break
                default:
                    let pathFinder = PathFinder()
                    pathFinder.position = CGPoint(x: 0, y: stallHeight/2 - 50)
                    stall.addChild(pathFinder)
                    break
                }
                
                newAdditionalHurdle = stall
                newAdditionalHurdle!.position = CGPoint(x: hurdleXPosition+40, y: ground.size.height+stall.frame.height/2 )
                
                let positionOfY = Double(ground.size.height)+Double(stall.telegaNode.size.height)+Double(stall.wheelNode.size.height/2)
                queueOfPathYPoints.enqueue((CGFloat(positionOfY), "main"))
                newAdditionalHurdle?.addChild(score)
                hurdleNumber += 1
                
                score.position = CGPoint(x: stallWidth/2+5, y: Double(frame.midY))
            }
            hurdleNumber += 1
            lastHurdleTypeRawValue = Int(newAdditionalHurdleType.rawValue)
            
            if let newAdditionalHurdle = newAdditionalHurdle {
                
                newAdditionalHurdle.run(moveAdditionalHurdleAndRemove)
                
                additionalHurdles.addChild(newAdditionalHurdle)
            }
        }
    }
    
    func valueInQueueFrom(additionalHurdle: SKNode?){
        let positionOfY = (additionalHurdle?.frame.size.height)!/2  + additionalHurdle!.position.y + 40
        valueInQueueFrom(positionOfY: positionOfY)
    }
    
    func valueInQueueFrom(positionOfY: CGFloat){
        let lastPosition = queueOfPathYPoints.last?.0 ?? 0
        if(lastPosition>positionOfY) {
            queueOfPathYPoints.enqueue((lastPosition, "additional"))
        }
        else{
            queueOfPathYPoints.enqueue((positionOfY, "additional"))
        }
        stackOfAditionalYPoints.push(positionOfY)
        //print("PaFa sub add")
    }
    
    func createHurdles() {
        guard !Enemy.isShown else {
            pathFinder?.isHidden=true
            while queueOfPathYPoints.count > 0 {
                queueOfPathYPoints.dequeue()
            }
            stackOfAditionalYPoints.clear()
            return }
        
        guard !Enemy.isShown, !isTheGamePaused, (animatingNode.speed > 0) else { return }
        
        if !isHurdlesAddedToAnimatingNode {
            animatingNode.addChild(hurdles)
            isHurdlesAddedToAnimatingNode = true
        }
        
        let hurdlePair = SKNode()
        hurdlePair.name = "hurdlePair"
        hurdlePair.position = CGPoint(x: self.frame.size.width, y: 0)
        hurdlePair.zPosition = 0
        
        let bottomHurdlePositionY = CGFloat(arc4random()).truncatingRemainder(dividingBy: CGFloat(size.height / 3 - 60))
        
       
        
        let hurdleAtBottom = Hurdle(isUpsideDown: false)
        hurdleAtBottom.name = "hurdleAtBottom"
        hurdleAtBottom.position = CGPoint(x: 0, y: bottomHurdlePositionY)
        hurdlePair.addChild(hurdleAtBottom)
        
        
        
        let hurdleCandyAtBottom = HurdleCandy()
        hurdleCandyAtBottom.name = "hurdleCandyAtBottom"
        hurdleCandyAtBottom.position = CGPoint(x: hurdleAtBottom.position.x, y: hurdleAtBottom.position.y + hurdleAtBottom.size.height / 2  - 25)
        hurdleCandyAtBottom.physicsBody = SKPhysicsBody(circleOfRadius: hurdleCandyAtBottom.size.width / 2)
        hurdleCandyAtBottom.physicsBody?.isDynamic = false
        hurdleCandyAtBottom.physicsBody?.categoryBitMask = Categories.hurdle.rawValue
        hurdlePair.addChild(hurdleCandyAtBottom)
        
        
        hurdleCandyAtBottom.healthIndicator.position = CGPoint(x: hurdleAtBottom.position.x+40, y: hurdleAtBottom.position.y + hurdleAtBottom.size.height / 2 - hurdleCandyAtBottom.size.width / 2 - 50)
        hurdleCandyAtBottom.healthIndicator.zPosition = 0
        hurdlePair.addChild(hurdleCandyAtBottom.healthIndicator)
        
        
        

        
        
        hurdleAtBottom.connectedHurdleCandy = hurdleCandyAtBottom
        hurdleCandyAtBottom.connectedHurdle = hurdleAtBottom
        
        
        let gap:CGFloat = 200.0
        let topHurdlePositionY = bottomHurdlePositionY + hurdleAtBottom.size.height + gap
        
        var positionOfY = bottomHurdlePositionY + hurdleAtBottom.size.height/2  + gap/2
        var currentElement = queueOfPathYPoints.count-1;
        while(currentElement>0){
            let bufPoint = queueOfPathYPoints.getElement(forIndex: currentElement)
            if bufPoint?.1 == "main" { break}
            else{
                let positionOfAdditionalY = stackOfAditionalYPoints.pop()!
                //print("PaFa \(bufPoint?.0) \(positionOfAdditionalY) \(positionOfY)")
                if positionOfY > positionOfAdditionalY  {
                    queueOfPathYPoints.replace((positionOfY, "additional"), index: currentElement)
                }
                else{
                    positionOfY = positionOfAdditionalY
                }
            }
            
            currentElement -= 1;
        }
        stackOfAditionalYPoints.clear()
        queueOfPathYPoints.enqueue((positionOfY, "main"))
        //print("PaFa add")
       
        
        //pathFinder?.moveTo(yPoint: queueOfPathYPoints.dequeue())
        let hurdleAtTop = Hurdle(isUpsideDown: true)
        hurdleAtTop.name = "hurdleAtTop"
        hurdleAtTop.position = CGPoint(x: 0, y: topHurdlePositionY)
        hurdlePair.addChild(hurdleAtTop)
        
        
        
        let hurdleCandyAtTop = HurdleCandy()
        hurdleCandyAtTop.name = "hurdleCandyAtTop"
        hurdleCandyAtTop.position = CGPoint(x: hurdleAtTop.position.x, y: hurdleAtTop.position.y - hurdleAtTop.size.height / 2 + 25)
        hurdleCandyAtTop.physicsBody = SKPhysicsBody(circleOfRadius: hurdleCandyAtTop.size.width / 2)
        hurdleCandyAtTop.physicsBody?.isDynamic = false
        hurdleCandyAtTop.physicsBody?.categoryBitMask = Categories.hurdle.rawValue
        hurdlePair.addChild(hurdleCandyAtTop)
        hurdleAtTop.connectedHurdleCandy = hurdleCandyAtTop
        hurdleCandyAtTop.connectedHurdle = hurdleAtTop
        
        hurdleCandyAtTop.healthIndicator.position = CGPoint(x: hurdleCandyAtTop.position.x+40, y: hurdleCandyAtTop.position.y + hurdleCandyAtTop.size.height / 2 - hurdleCandyAtTop.size.width / 2 + 50)
        hurdleCandyAtTop.healthIndicator.zPosition = 0
        hurdlePair.addChild(hurdleCandyAtTop.healthIndicator)
        
        
        let candy = Candy(candy: Candies.randomCandy())
        candy.position = CGPoint(x: 0.0,
                                 y: CGFloat(hurdleCandyAtBottom.position.y) + (CGFloat(gap / 2)))
        candy.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: candy.size.width * 2, height: candy.size.height * 2))
        candy.physicsBody?.isDynamic = false
        candy.physicsBody?.categoryBitMask = Categories.dollar.rawValue
        candy.beginAnimation()
        hurdlePair.addChild(candy)
        
        let candyToDollars = CandyToDollars()
        candyToDollars.position = CGPoint(x: candy.position.x, y: candy.position.y + 50.0)
        candyToDollars.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: candy.size.width, height: candy.size.height + 50.0))
        candyToDollars.physicsBody?.isDynamic = false
        candyToDollars.physicsBody?.categoryBitMask = Categories.candyToDollar.rawValue
        hurdlePair.addChild(candyToDollars)
        
        let score = SKNode()
        score.position = CGPoint(x: hurdleAtBottom.size.width + plane.size.width / 5, y: frame.midY)
        score.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hurdleAtBottom.size.width, height: frame.height))
        score.physicsBody?.isDynamic = true
        score.physicsBody?.affectedByGravity = false
        score.physicsBody?.allowsRotation = false
        score.physicsBody?.categoryBitMask = Categories.score.rawValue
        
        score.physicsBody?.collisionBitMask = 0//Categories.score.rawValue
        hurdlePair.addChild(score)
        
        
        
        hurdlePair.removeFromParent()
        hurdlePair.run(moveHurdleAndRemove)
        
        if animatingNode.speed > 0 {
            hurdleCandyAtBottom.beginRotating()
            hurdleCandyAtTop.beginRotating()
        }
        
        hurdles.addChild(hurdlePair)
        NSLog("Hurdle Speed", animatingNode.speed)
        
        createAdditionalHurdles()
        
    }
    
    
    // Hurdle after SAVE ME
    func createHurdle() {
        
       
        
        if !isHurdlesAddedToAnimatingNode {
            animatingNode.addChild(hurdles)
            isHurdlesAddedToAnimatingNode = true
        }
        
        let hurdlePair = SKNode()
        hurdlePair.name = "hurdlePair"
        hurdlePair.position = CGPoint(x: self.frame.size.width, y: 0)
        hurdlePair.zPosition = 0
        
        let bottomHurdlePositionY = CGFloat(arc4random()).truncatingRemainder(dividingBy: CGFloat(size.height / 3))
        
        let hurdleAtBottom = Hurdle(isUpsideDown: false)
        hurdleAtBottom.name = "hurdleAtBottom"
        hurdleAtBottom.position = CGPoint(x: 0, y: bottomHurdlePositionY)
        hurdlePair.addChild(hurdleAtBottom)
        
        let hurdleCandyAtBottom = HurdleCandy()
        hurdleCandyAtBottom.name = "hurdleCandyAtBottom"
        hurdleCandyAtBottom.position = CGPoint(x: hurdleAtBottom.position.x,
                                               y: hurdleAtBottom.position.y + hurdleAtBottom.size.height / 2 - hurdleCandyAtBottom.size.width / 2)
        hurdleCandyAtBottom.physicsBody = SKPhysicsBody(circleOfRadius: hurdleCandyAtBottom.size.width / 2)
        hurdleCandyAtBottom.physicsBody?.isDynamic = false
        hurdleCandyAtBottom.physicsBody?.categoryBitMask = Categories.hurdle.rawValue
        hurdlePair.addChild(hurdleCandyAtBottom)
        hurdleAtBottom.connectedHurdleCandy = hurdleCandyAtBottom
        hurdleCandyAtBottom.connectedHurdle = hurdleAtBottom
        
        let gap:CGFloat = 150.0
        let topHurdlePositionY = bottomHurdlePositionY + hurdleAtBottom.size.height + gap
        
        let hurdleAtTop = Hurdle(isUpsideDown: true)
        hurdleAtTop.name = "hurdleAtTop"
        hurdleAtTop.position = CGPoint(x: 0, y: topHurdlePositionY)
        hurdlePair.addChild(hurdleAtTop)
        
        let hurdleCandyAtTop = HurdleCandy()
        hurdleCandyAtTop.name = "hurdleCandyAtTop"
        hurdleCandyAtTop.position = CGPoint(x: hurdleAtTop.position.x, y: hurdleAtTop.position.y - hurdleAtTop.size.height / 2 + hurdleCandyAtTop.size.width / 2)
        hurdleCandyAtTop.physicsBody = SKPhysicsBody(circleOfRadius: hurdleCandyAtTop.size.width / 2)
        hurdleCandyAtTop.physicsBody?.isDynamic = false
        hurdleCandyAtTop.physicsBody?.categoryBitMask = Categories.hurdle.rawValue
        hurdlePair.addChild(hurdleCandyAtTop)
        hurdleAtTop.connectedHurdleCandy = hurdleCandyAtTop
        hurdleCandyAtTop.connectedHurdle = hurdleAtTop
        
        hurdlePair.position = CGPoint(x: size.width / 2, y: -25.0)
        
        hurdleCandyAtBottom.beginRotating()
        hurdleCandyAtTop.beginRotating()
        
        let hurdleAtBottomAnimation = SKAction.moveTo(y: 57.0, duration: 1.0)
        let hurdleCandyAtBottomAnimation = SKAction.moveTo(y: 57 + hurdleAtBottom.size.height / 2 - hurdleCandyAtBottom.size.width / 2, duration: 1.0)
        
        let hurdleAtTopPosition = size.height + hurdleAtTop.size.height / 2 - 104.0
        let hurdleCandyAtTopPosition = hurdleAtTopPosition - hurdleAtTop.size.height / 2 + hurdleCandyAtTop.size.width / 2
        let hurdleAtTopAnimation = SKAction.moveTo(y: hurdleAtTopPosition, duration: 1.0)
        let hurdleCandyAtTopAnimation = SKAction.moveTo(y: hurdleCandyAtTopPosition, duration: 1.0)
        
        hurdleAtBottom.run(hurdleAtBottomAnimation)
        hurdleCandyAtBottom.run(hurdleCandyAtBottomAnimation)
        hurdleAtTop.run(hurdleAtTopAnimation)
        hurdleCandyAtTop.run(hurdleCandyAtTopAnimation)
        
        resumedHurdle = hurdlePair
        
        addChild(hurdlePair)
    }
    
    func createDollarWallet() {
        dollarWallet.zPosition = 4
        dollarWallet.name = "DollarWallet"
        dollarWallet.position = CGPoint(x: size.width / 2.5, y: size.height / 1.05)
        dollarWallet.updateDollarsCount()
        addChild(dollarWallet)
    }
    
    func createPurchasedDollars() {
        dollarWallet.zPosition = 3
        purchasedDollarsWallet.name = "PurchasedDollars"
        purchasedDollarsWallet.position = CGPoint(x: dollarWallet.position.x, y: dollarWallet.position.y - 100.0)
        purchasedDollarsWallet.isHidden = true
        addChild(purchasedDollarsWallet)
    }
    
    func createScoreWallet() {
        if !isTheGameResumed && !isTheGamePaused {
            initializeScoreToGameData(0)
        }
        scoreWallet.zPosition = 4
        scoreWallet.position = CGPoint(x: size.width / 1.55, y: size.height / 1.05)
        scoreWallet.isHighScore = false
        scoreWallet.updateScoresCount()
        addChild(scoreWallet)
    }
    
    func createGameOver() {
        gameOver.setScale(0.0)
        gameOver.position = CGPoint(x: size.width / 2, y: size.height / 2)
        gameOver.zPosition = 5
        addChild(gameOver)
    }
    
    func createInAppPurchase() {
        inAppPurchase.zPosition = 6
        inAppPurchase.setScale(0.0)
        inAppPurchase.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(inAppPurchase)
    }
    
    func createCandyToDollars() {
        candyToDollars = CandyToDollars()
        candyToDollars.position = CGPoint(x: size.width / 1.5, y: size.height / 1.5)
        addChild(candyToDollars)
    }
    
    func createSaveMe() {
        saveMe.zPosition = 5
        saveMe.setScale(0.0)
        saveMe.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(saveMe)
    }

    func createBomb() -> Bomb {
        let bomb = Bomb()
        
        bomb.position = CGPoint(x: frame.size.width*2/3, y: frame.size.height/2)
        let moveTop = SKAction.moveTo(y: size.height/5, duration: 2)
        let moveBottom = SKAction.moveTo(y: (size.height*4)/5, duration: 2)
        let movement = SKAction.repeatForever(SKAction.sequence([moveTop, moveBottom]))
        bomb.run(movement)

        return bomb
    }
    
    func createDonuts() -> Donuts{
        return Donuts()
    }
    
    func createEnemy() {
        enemy = Enemy()
        enemy?.position = CGPoint(x: frame.size.width*2/3, y: frame.size.height*0.8)
        
        let xDelta = CGFloat(30)
        let yDelta = 0.15*frame.size.height
        
        let moveUp1 = SKAction.moveBy(x: -xDelta, y: yDelta, duration: 0.75)
        let moveUp2 = SKAction.moveBy(x: xDelta, y: yDelta, duration: 0.75)
        let moveDown1 = SKAction.moveBy(x: -xDelta, y: -yDelta, duration: 0.75)
        let moveDown2 = SKAction.moveBy(x: xDelta, y: -yDelta, duration: 0.75)
        
        let movement = SKAction.repeatForever(SKAction.sequence([moveDown1, moveDown2, moveDown1, moveDown2, moveUp1, moveUp2, moveUp1, moveUp2]))
        self.run(SKAction.playSoundFileNamed("007-0.mp3", waitForCompletion: false))
        enemy?.run(movement)
        enemy?.beginAnimation()
        addChild((enemy)!)
    }
    
    func createPathFinder(){
        pathFinder = PathFinder()
        pathFinder?.isHidden = true
        pathFinder?.position = CGPoint(x: size.width / 2 + 120, y: size.height / 2)//CGPoint(x: size.width * 2 / 3, y: size.height/2)
        pathFinder?.physicsBody = SKPhysicsBody(circleOfRadius: (pathFinder?.size.width)!/2)
        pathFinder?.physicsBody?.isDynamic = false//true
        pathFinder?.physicsBody?.allowsRotation = false
        pathFinder?.physicsBody?.affectedByGravity = false
        pathFinder?.physicsBody?.categoryBitMask = Categories.pathFinder.rawValue
        pathFinder?.physicsBody?.contactTestBitMask = Categories.score.rawValue
        pathFinder?.physicsBody?.collisionBitMask = 0
        addChild(pathFinder!)
        //queueOfPathYPoints.dequeue()
        pathFinder?.moveTo(yPoint: queueOfPathYPoints.dequeue()?.0)
    
    }
    func createBaloon(){
        baloon = Balloon()
        baloon.position = CGPoint(x: size.width / 2, y: size.height / 2+50)//CGPoint(x: size.width * 2 / 3, y: size.height/2)
        baloon.physicsBody = SKPhysicsBody(circleOfRadius: (pathFinder?.size.width)!/2)
        baloon.physicsBody?.isDynamic = false
        baloon.physicsBody?.allowsRotation = false
        baloon.physicsBody?.affectedByGravity = false
        baloon.physicsBody?.categoryBitMask = Categories.pathFinder.rawValue
        baloon.physicsBody?.contactTestBitMask = Categories.score.rawValue
       // baloon.physicsBody?.contactTestBitMask = Categories.pathFinder.rawValue
        baloon.physicsBody?.collisionBitMask = 0
        addChild(baloon)
        baloon.isHidden = true
        
        baloon.moveTo(yPoint: queueOfPathForBaloon.dequeue())
        
        
       /* let firstPosition = convert(baloon.position,
                                                to: self)
        let secondPosition = convert(CGPoint(x: plane.position.x-40, y: plane.position.y),
                                    to: self)
        let pinJoint = SKPhysicsJointLimit.joint(withBodyA: baloon.physicsBody!,
                                               bodyB: plane.physicsBody!,
                                               anchorA: firstPosition, anchorB: secondPosition)
        physicsWorld.add(pinJoint)*/
    }
    
}
