//
//  GameScene.swift
//  FlyPlane
//
//  Created by Dexter on 22/04/16.
//  Copyright (c) 2016 Studio2Entertainment. All rights reserved.
//

import SpriteKit
import StoreKit
import GoogleMobileAds

class GameScene: BaseScene {
    
    
    // MARK: Properties
    
   
    var protocolDelegate : SceneDelegate?
    
    
    var ground = Ground()
    var road = Road()
    var mountain = Mountain()
    
    var skyLimit = SKNode()
    
    var animatingNode = SKNode()
    var additionalAnimatingNode = SKNode()
    var isAnimating = Bool()
    
    var hurdles = SKNode()
    var hurdle = SKTexture(image: #imageLiteral(resourceName: "Hurdle"))
    
    var resumedHurdle = SKNode()
    var moveHurdleAndRemove = SKAction()
    var endlessHurdles = SKAction()
    
    let worldMovementSpeedMultiplier = 0.0038 * 1.7
    let hurdlesOccurenceFrequencyDivider = 2.0
    
    var additionalHurdles = SKNode()
    // To controll that new lollipops appear at least each 3 hurdles
    var nonLollipopHurdlesCount = 0
    var nonStallHurdleCount = 0
    var nonBubbleHurdleCount = 0
    
    
    var resumedAdditionalHurdle = SKNode()
    var moveAdditionalHurdleAndRemove = SKAction()
    var endlessAdditionalHurdles = SKAction()
    
    var isHurdlesAddedToAnimatingNode = Bool()
    var isAdditionalHurdlesAddedToAdditionalAnimatingNode = Bool()
    
    var dollarWallet = DollarWallet()
    var purchasedDollarsWallet = PurchasedDollars()
    
    var scoreWallet = Score()
    
    var saveMe = SaveMe()
    var gameOver = GameOver()
    var inAppPurchase = InAppPurchase()
    
    var candyToDollars = CandyToDollars()
    var candyType = String()
    
    var flag = Bool()
    var isTheGamePaused = Bool()
    var isTheGameResumed = Bool()
    
    var upHeightControl = HeightControl(withDirection: .up)
    var downHeightControl = HeightControl(withDirection: .down)
    var shootingControl = ShootControll()
    var bubbleIndicator = BubbleIndicator()
    var rocketIndicator = RocketIndicator()
    var rocketChanger = RocketChanger()
    var pathFinderControl = PathFinderControl()
    var enemy: Enemy?
    var pathFinder: PathFinder?
    var queueOfPathYPoints = Queue<(value: CGFloat, type: String)>()
    var queueOfPathForBaloon = Queue<CGFloat>()
    var stackOfAditionalYPoints = Stack<CGFloat>()
    var baloon = Balloon()
    var connectionRope :Rope? = nil
    var ballonControl = BalloonControl()
    var setupBubbleAfterStore: Bool = false
    var setupBalloonAfterStore: Bool = false
    
    var planeTouchCandy = false
    var planeTouchDollar = false
    var planeTouchScore = false
    var planeTouchSuperPower = false
    var planeTouchBullet = false
    var afterBubbleFlag = false
    static var lossCounter = 0
    var waitingForAdv = false
    var showingTutorial = false
    
    // MARK: Lifecycle
    
    func setupProperties(){
        
        self.viewController?.adBannerView.isHidden = true
        
        plane = Plane()
        ground = Ground()
        road = Road()
        mountain = Mountain()
        
        skyLimit = SKNode()
        
        animatingNode = SKNode()
        additionalAnimatingNode = SKNode()
        isAnimating = Bool()
        
        hurdles = SKNode()
        hurdle = SKTexture(image: #imageLiteral(resourceName: "Hurdle"))
        
        resumedHurdle = SKNode()
        moveHurdleAndRemove = SKAction()
        endlessHurdles = SKAction()

        
        additionalHurdles = SKNode()
        // To controll that new lollipops appear at least each 3 hurdles
        nonLollipopHurdlesCount = 0
        nonStallHurdleCount = 0
        nonBubbleHurdleCount = 0
        
        
        resumedAdditionalHurdle = SKNode()
        moveAdditionalHurdleAndRemove = SKAction()
        endlessAdditionalHurdles = SKAction()
        
        isHurdlesAddedToAnimatingNode = Bool()
        isAdditionalHurdlesAddedToAdditionalAnimatingNode = Bool()
        
        dollarWallet = DollarWallet()
        purchasedDollarsWallet = PurchasedDollars()
        
        scoreWallet = Score()
        
        saveMe = SaveMe()
        gameOver = GameOver()
        inAppPurchase = InAppPurchase()
        
        candyToDollars = CandyToDollars()
        candyType = String()
        
        flag = Bool()
        isTheGamePaused = Bool()
        isTheGameResumed = Bool()
        
        upHeightControl = HeightControl(withDirection: .up)
        downHeightControl = HeightControl(withDirection: .down)
        shootingControl = ShootControll()
        bubbleIndicator = BubbleIndicator()
        rocketIndicator = RocketIndicator()
        rocketChanger = RocketChanger()
        pathFinderControl = PathFinderControl()
        enemy = nil
        pathFinder = nil
        queueOfPathYPoints = Queue<(value: CGFloat, type: String)>()
        queueOfPathForBaloon = Queue<CGFloat>()
        stackOfAditionalYPoints = Stack<CGFloat>()
        baloon = Balloon()
        connectionRope  = nil
        ballonControl = BalloonControl()
        setupBubbleAfterStore = false
        setupBalloonAfterStore = false
        
        
        
        
        pauseBackground = SKSpriteNode()
        
        viewController = nil
        planeTouchCandy = false
        planeTouchDollar = false
        planeTouchScore = false
        planeTouchSuperPower = false
        planeTouchBullet = false
        afterBubbleFlag = false
        store = nil
        waitingForAdv = false
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        Chartboost.setDelegate(self)
        subscribeToStoreManagerDelegate()
        configureGameResuming()
        
        AudioPlayer.shared.startGameSceneBackgroundMusic()
        
        if isTheGamePaused == true {
            isUserInteractionEnabled = false
            createAnimatingNode()
            createSky()
            createGround()
            createRoad()
            createMountain()
            delay(1.3, closure: { () -> () in
                self.createPlane()
                self.isUserInteractionEnabled = true
                //self.createHurdles()
                self.createDollarWallet()
                self.createPurchasedDollars()
                self.createScoreWallet()
                self.createGameOver()
                self.createInAppPurchase()
                self.createSaveMe()
                self.moveAndCreateEndlessHurdles()
                self.moveAndCreateEndlessAdditionalHurdles()
                self.createPhysics()
                self.createPathFinder()
                self.createBaloon()
                self.isTheGameResumed = true
            })
        } else {
            createControls()
            createAnimatingNode()
            createSky()
            createPlane()
            createGround()
            createRoad()
            createMountain()
            //createHurdles()
            createDollarWallet()
            createPurchasedDollars()
            createScoreWallet()
            createGameOver()
            createInAppPurchase()
            createSaveMe()
            moveAndCreateEndlessHurdles()
            moveAndCreateEndlessAdditionalHurdles()
            createPhysics()
            createPathFinder()
            createBaloon()
            
            showTutorialIfNeeded()
            NotificationCenter.default.addObserver(self, selector: #selector(GameScene.inBackground), name:NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
            //Chartboost.showInterstitial(CBLocationHomeScreen)
        }
        
       
        
    }
    
    
    func showTutorialIfNeeded() {
        if !isTutorialShowedFirstTimeGameScene {
            self.showGameTutorial()
            isTutorialShowedFirstTimeGameScene = true
        }
    }
    
    // MARK: Actions
    
    func makePlaneJump(withDirection direction: HeightControl.Direction) {
        var dy = 10.0
        if direction == .down {
            dy *= -1
            self.playSound(sound: audioFileNames.planeDown)
        } else {
           self.playSound(sound: audioFileNames.planeUp)
        }
        
        plane.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: dy))
    }
    
    func bumpFromHurdle(){
        plane.removeAction(forKey: "returnAction")
        //plane.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 125))
        
        
        self.run(SKAction.playSoundFileNamed("004-4.mp3", waitForCompletion: false))
        plane.run(SKAction.moveTo(y: size.height * 0.75, duration: 0.25))
       // plane.physicsBody = nil
        delay(0.1, closure: {
            if self.plane.isBubbleEnabled {
                self.plane.setBubblePhysics()
            }
            else{
                self.plane.setInitialPhysics()
            }
            /*delay(0.5, closure: {
                let returnAction = SKAction.moveTo(x: (self.plane.scene?.frame.width)!/2, duration: 1.0)//(named: "returnAction")
                //returnAction.moveTo(x: (self.plane.scene?.frame.width)!/2, duration: 1.0)
                
                self.plane.run(returnAction, withKey: "returnAction")
                })*/
            })
        
    }
    
    func moveResumedHurdleAndRemove() -> SKAction {
        let distanceToMove = size.width / 2 + hurdle.size().width;
        let moveHurdle = SKAction.moveBy(x: -distanceToMove, y: 0, duration: worldMovementSpeedMultiplier * Double(distanceToMove))
        let removeHurdle = SKAction.removeFromParent()
        return SKAction.sequence([moveHurdle, removeHurdle])
    }
    
    func moveAndCreateEndlessHurdles() {
       
        let distanceToMove = size.width
        let moveHurdle = SKAction.moveBy(x: -distanceToMove, y: 0, duration: worldMovementSpeedMultiplier * Double(distanceToMove))
        let removeHurdle = SKAction.removeFromParent()
        moveHurdleAndRemove = SKAction.sequence([moveHurdle, removeHurdle])

        let createHurdle = SKAction.run({ self.createHurdles() })
        let afterDelay = SKAction.wait(forDuration: worldMovementSpeedMultiplier * Double(distanceToMove) / hurdlesOccurenceFrequencyDivider)
        let createHurdleAfterDelay = SKAction.sequence([createHurdle, afterDelay])
        
        endlessHurdles = SKAction.repeatForever(createHurdleAfterDelay)
        
    }
    
    func moveAndCreateEndlessAdditionalHurdles() {
        let distanceToMove = size.width + size.width
        let moveHurdle = SKAction.moveBy(x: -distanceToMove, y: 0, duration: worldMovementSpeedMultiplier * Double(distanceToMove))
        let removeHurdle = SKAction.removeFromParent()
        moveAdditionalHurdleAndRemove = SKAction.sequence([moveHurdle, removeHurdle])
        
//        let createAdditionalHurdle = SKAction.run({ self.createAdditionalHurdles() })
//        let afterDelay = SKAction.wait(forDuration: worldMovementSpeedMultiplier * Double(distanceToMove))
//        let createAdditionalHurdleAfterDelay = SKAction.sequence([createAdditionalHurdle, afterDelay])
//        endlessAdditionalHurdles = SKAction.repeatForever(createAdditionalHurdleAfterDelay)
    }
    
    func beginEndlessHurdles() {
        run(endlessHurdles, withKey: "endlessHurdles")//(endlessHurdles)
        
    }
    
    func beginEndlessAdditionalHurdles() {
        run(endlessAdditionalHurdles)
    }
    
    func tiltConstraints(_ min: CGFloat, max: CGFloat, value: CGFloat) -> CGFloat {
        
        if value > max {
            return max
        } else if value < min {
            return min
        } else {
            return value
        }
    }
    
//    func getProductForIdentifer(_ productIdentifier: String) -> SKProduct {
//        for (_, product) in StoreManager.sharedInstance.loadedProducts.enumerated() {
//            if product.productIdentifier == productIdentifier {
//                return product
//            }
//        }
//        return SKProduct()
//    }
   
    override func update(_ currentTime: TimeInterval) {
        guard plane.physicsBody != nil else { return }
        
        if isAnimating {
            if animatingNode.speed > 0 {
                let zRotationValue: CGFloat = (plane.physicsBody!.velocity.dy) * (plane.physicsBody!.velocity.dx < 0 ? 0.005625 : 0.00125)
                plane.zRotation = tiltConstraints(-1, max: 0.5, value: zRotationValue)
            }
        }
    }
    
    func updateScore() {
        GameScore += 1
        initializeScoreToGameData(GameScore)
        scoreWallet.isHighScore = false
        scoreWallet.updateScoresCount()
    }
    
    func updateScoreAndHighScoreToGameData() {
       // getScoreFromGameData()
        updateHighScoreToGameData(GameScore)
        GameHighScore = getHighScoreFromGameData()
        gameOver.score.isHighScore = false
        gameOver.score.updateScoresCount()
        gameOver.positionScore()
        gameOver.highScore.isHighScore = true
        gameOver.highScore.updateScoresCount()
        gameOver.positionHighScore()
    }
    
    func pauseGame() {
        AudioPlayer.shared.stop()
        // fix issue with green health indicator
        for child in self.children {
            if let crashableChild = child as? CrashableNode {
                crashableChild.healthIndicator.isHidden = true
            }
        }
        for child in self.hurdles.children {
            for hurdlePair in child.children {
                if let crashableChild = hurdlePair as? CrashableNode {
                    crashableChild.healthIndicator.isHidden = true
                }
            }
        }
        for child in self.additionalHurdles.children {
            if let crashableChild = child as? CrashableNode {
                crashableChild.healthIndicator.isHidden = true
            }
        }
        
        DispatchQueue.main.async {
            self.dollarWallet.isHidden = true
            self.scoreWallet.isHidden = true
        }
        
        let qualityOfServiceIdentifier = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceIdentifier)
        self.additionalAnimatingNode.speed = 0
        self.animatingNode.speed = 0
        self.removeAllActions()
        backgroundQueue.async(execute: {
        
            //  Play audio sound effects on user tap!
            /*AudioPlayer.stop()
            AudioPlayer.playGameOverMusicFX()*/
            //if !GameMuteState {self.run(SKAction.playSoundFileNamed("Game Over fx.wav", waitForCompletion: false))}
            self.playSound(sound: .gameOver)
            self.playSound(sound: .whirlybirdDead)
            
            
            
            DispatchQueue.main.async(execute: { () -> Void in
                Enemy.isShown = false
                if(!isAdBlocked){
                    //print(">>> showing bannerr")
                    self.viewController?.adBannerView.isHidden = false
                    self.viewController!.adBannerView.removeFromSuperview()
                    self.view!.addSubview(self.viewController!.adBannerView)
                }
                self.upHeightControl.removeFromParent()
                self.downHeightControl.removeFromParent()
                self.bubbleIndicator.removeFromParent()
                self.rocketIndicator.removeFromParent()
                self.rocketChanger.removeFromParent()
                self.pathFinderControl.removeFromParent()
                self.shootingControl.removeFromParent()
                self.ballonControl.removeFromParent()

                let rotatePlane = SKAction.rotate(byAngle: 0.01, duration: 0.003)
                let stopPlane = SKAction.run({ self.plane.speed = 0 })
                
                let slowDownPlane = SKAction.sequence([rotatePlane, stopPlane])
                self.plane.run(slowDownPlane)
                
                self.plane.physicsBody?.affectedByGravity = true
                
                delay(1, closure: {
                    self.enemy?.leaveScene()
                    self.enemy = nil
                    let isScoreBelowFive = GameScore < 5
                    if (isScoreBelowFive) {
                        DispatchQueue.main.async(execute: { () -> Void in
                            //print(GameScene.lossCounter)
                            if GameScene.lossCounter >= 2 {
                                GameScene.lossCounter = 0
                                
                                if(!isAdBlocked && InternetConnectivity.isConnectedToNetwork()){
                                    
                                    self.waitingForAdv = true
                                    
                                    DispatchQueue.main.async {
                                        Chartboost.showInterstitial(CBLocationHomeScreen)
                                    }
                                }
                               
                                
                            }
                            else{
                                GameScene.lossCounter += 1
                            }
                        })
                        self.loadPauseBackground()
                        
                        self.gameOver.beginAnimation({ (action) -> Void in
                            self.run(SKAction.playSoundFileNamed("008-2.mp3", waitForCompletion: false))
                            self.gameOver.run(action, completion: { () -> Void in
                                self.updateScoreAndHighScoreToGameData()
                            })
                        })
                        
                        
                    } else {
                        self.saveMe.beginAnimation({ (action) -> Void in
                            self.run(SKAction.playSoundFileNamed("008-0.mp3", waitForCompletion: false))
                            self.saveMe.run(action, completion: { () -> Void in
                                self.updateScoreAndHighScoreToGameData()
                                self.saveMe.updateDollarsCount()
                            })
                        })
                    }
                })
            })
        })
    }
    
    func subscribeToStoreManagerDelegate() {
//        StoreManager.sharedInstance.delegate = self
    }
    
    func configureGameResuming() {
        if isTheGamePaused {
            self.isTheGameResumed = true
            self.run(SKAction.run({ () in self.createHurdle() }))
        }
    }
    
    func resumeGame() {
        scoreWallet.isHidden = false
        Enemy.isShown = false
        addChild(upHeightControl)
        addChild(downHeightControl)
        addChild(bubbleIndicator)
        addChild(rocketIndicator)
        addChild(rocketChanger)
        addChild(pathFinderControl)
        addChild(ballonControl)
        self.run(SKAction.playSoundFileNamed("008-1.mp3", waitForCompletion: false))
        AudioPlayer.shared.startGameSceneBackgroundMusic()
    }
    
    func drawCandyAnimationCurvePath(_ candy: SKNode) -> CGPath {
        // Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: candy.position.x, y: candy.position.y))
        bezierPath.addLine(to: CGPoint(x: -125.0, y: 735.5))
        UIColor.black.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
        
        return bezierPath.cgPath
    }
    
    func getCandyActionSequenceSequence(_ coin: SKNode) -> SKAction {
        let path = drawCandyAnimationCurvePath(coin)
        
        let followPath = SKAction.follow(path, asOffset: false, orientToPath: false, duration: 0.5)
        let remove = SKAction.removeFromParent()
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        
        let sequence = SKAction.sequence([followPath, remove])
        let animation = SKAction.group([fadeOut, sequence])
        
        return animation
    }
    
    func collect(basePower: BaseSuperPower) {
        
        let superPower = basePower.powerType
        
        self.run(SKAction.playSoundFileNamed("001-5.mp3", waitForCompletion: false))
        
        switch superPower {
            
        case .bubble:
            PlayersBackpack.bubblesCount += 1
            bubbleIndicator.updateCounter()
            break
            
        case .bullets:
            
            PlayersBackpack.bulletsCount += basePower.bulletCount
            shootingControl.updateBullets(count: PlayersBackpack.bulletsCount)
            break
            
        case .rocket:
            
            switch basePower.rocketType {
            case .type1:
                PlayersBackpack.rocketsCount[.type1]! += 1
                break
            case .type2:
                PlayersBackpack.rocketsCount[.type2]! += 1
                break
            case .type3:
                PlayersBackpack.rocketsCount[.type3]! += 1
                break
            case .type4:
                PlayersBackpack.rocketsCount[.type4]! += 1
                break
            case .type5:
                PlayersBackpack.rocketsCount[.type5]! += 1
                break
            default:
                break
            }
            
            self.rocketIndicator.updateCounter(with: PlayersBackpack.rocketsCount[basePower.rocketType]!)
            break
            
        case .unspecified:
            break
        
        }
    }
    
    func activate(superPower: SuperPowers) {
        switch superPower {
        case .bubble:
            guard PlayersBackpack.bubblesCount > 0, !plane.isBubbleEnabled else { return }
            PlayersBackpack.bubblesCount -= 1
            bubbleIndicator.beginAnimation()
            bubbleIndicator.updateCounter()
            plane.useBubble()
            bubbleIndicator.startCountdown(plane: plane)
            self.playSound(sound: .activeBubble)
            break
        case .unspecified:
            break
        default: break
        }
    }
    
    func sceneOnPause(){
        //print("SceneOnPause")
        //AudioPlayer.shared.stop()
        (self.view as! GameSceneView).sceneShouldBePaused = true
        self.additionalAnimatingNode.speed = 0
        self.animatingNode.speed = 0
        self.enemy?.stop()
        self.plane.isPaused = true
        self.physicsWorld.speed = 0
        self.isPaused = true
    }
    
    func sceneResume(){
        //print("sceneResume")
        (self.view as! GameSceneView).sceneShouldBePaused = false
        self.additionalAnimatingNode.speed = 1
        self.animatingNode.speed = 1
        self.enemy?.resume()
        self.plane.isPaused = false
        self.physicsWorld.speed = 1
        if setupBubbleAfterStore {
            setupBubbleAfterStore = false
            activate(superPower: .bubble)
        }
        else if setupBalloonAfterStore {
            setupBalloonAfterStore = false
            balloonActivate()
            ballonControl.beginAnimation()
        }
        self.run(SKAction.playSoundFileNamed("008-1.mp3", waitForCompletion: false))
        self.isPaused = false
        self.view?.isPaused = false
        store = nil
    }
    
    func updateCounters() {
        updateCounterWithId(0)
        updateCounterWithId(1)
        updateCounterWithId(2)
        updateCounterWithId(3)
        updateCounterWithId(4)
    }
    
    func updateCounterWithId(_ id: Int){
        switch id {
        case 0: self.bubbleIndicator.updateCounter()
        case 1: self.shootingControl.updateBullets(count: PlayersBackpack.bulletsCount)
        case 2: self.ballonControl.updateCounter()
        case 3: self.pathFinderControl.updateCounter()
        default: self.rocketIndicator.updateCounter(with: PlayersBackpack.rocketsCount[Plane.currentRocketType]!)
            self.rocketIndicator.texture = SKTexture(image: Plane.currentRocketType.getIndicatorImage())
        }
    }
    
    func pathFinderActivate(){
        pathFinderControl.beginAnimation()
        if pathFinder?.parent != nil  {
            pathFinder?.isHidden = false
            pathFinderControl.startCountdown(pathFinder: pathFinder)
        }
    
    }
    
    func balloonActivate(){
        
        if PlayersBackpack.balloonCount>0 {
            baloon.isHidden = false
            plane.isBalloonEnabled = true
            connectionRope = Rope()
            
            
            addChild(connectionRope!)
            connectionRope!.setAttachmentPoint(point: CGPoint(x: baloon.position.x, y: baloon.position.y - baloon.frame.width/2), node: baloon)
            connectionRope!.attachedObject = plane//ball//plane
            connectionRope!.setRopeLenght(ropeLenght: 4)
            let physicsJointLimit = SKPhysicsJointLimit.joint(withBodyA: baloon.physicsBody!, bodyB: plane.physicsBody!, anchorA: CGPoint(x: baloon.position.x, y: baloon.position.y - baloon.frame.width/2), anchorB: plane.position)
            physicsJointLimit.maxLength = 100
            physicsWorld.add(physicsJointLimit)
            
            ballonControl.startCountdown(plane: plane, balloon: baloon, rope: connectionRope)
           
        }
    }
    
    func inBackground(){
        //pause()
    }
}
