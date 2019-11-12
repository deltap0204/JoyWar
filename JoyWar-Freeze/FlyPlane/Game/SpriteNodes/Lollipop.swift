//
//  Lollipop.swift
//  Game
//
//  Created by Developer on 03.05.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import Foundation
import SpriteKit

enum LollipopTheme: Int{
    
    case theme1 = 1
    case theme2 = 2
    case theme3 = 3
    case theme4 = 4
    case theme5 = 5
    case theme6 = 6
    
    var textures: [SKTexture] {
        var values: [SKTexture] = []
        for i in 1...8 {
            values.append(SKTexture(imageNamed: textureName+"-\(i)"))
        }
        
        return values
    }
    var powderTextures: [SKTexture] {
        var values: [SKTexture] = []
        for i in 1...6 {
            values.append(SKTexture(imageNamed: "Powder\(i)"))
        }
        return values
    }
    
    var stickTexture: SKTexture {
        return SKTexture(imageNamed: stickName)
    }
    private var textureName: String {
        return "Lollipop-Type\(self.rawValue)"
    }
    private var stickName: String {
        return "Stick\(self.rawValue)"
    }
    
}

class Lollipop: SKSpriteNode, Cashable {
    
    
    // MARK: Properties
    var price: hurdleCandyPricing = .lolipop
    var theme = LollipopTheme.theme1
    var staticStick: SKSpriteNode
    var powderAnimationLayer: SKSpriteNode
    
    // MARK: Lifecycle
    
    init(withTheme theme: LollipopTheme) {
        
        self.theme = theme
        let initialTexture = theme.textures[0]
        let stickTexture = theme.stickTexture
        staticStick = SKSpriteNode(texture: stickTexture, color: UIColor(), size: CGSize(width: stickTexture.size().width/8, height: stickTexture.size().height/8))
        powderAnimationLayer = SKSpriteNode(texture: nil)
        super.init(texture: initialTexture, color: UIColor(), size: CGSize(width: initialTexture.size().width/2, height: initialTexture.size().height/2))
        powderAnimationLayer.size = initialTexture.size()
        staticStick.position.y -= self.size.height*3/4 - 13
        addChild(staticStick)
        addChild(powderAnimationLayer)
        zPosition = -1
        
        staticStick.physicsBody = nil

        let candyPhysicsBody = SKPhysicsBody(circleOfRadius: size.width/5, center: CGPoint(x: 0, y: 40))
        let stickPhysicsBody = SKPhysicsBody(rectangleOf: CGSize(width: staticStick.size.width,
                                                                 height: self.size.height),
                                             center: CGPoint(x: self.frame.midX, y: self.frame.midY - 30))
        physicsBody = SKPhysicsBody(bodies: [candyPhysicsBody, stickPhysicsBody])
        
        
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitMask = Categories.hurdle.rawValue
        
        
        name = "lollipop"
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: Crashable

extension Lollipop: Crashable {
    
    func beginCrashAnimation(withCompletion completion: (()->())?) {
        
        
        
        self.physicsBody = nil
        staticStick.physicsBody = nil
        let beforePowderAppearedAnimation = SKAction.animate(with: Array(theme.textures.prefix(upTo: 6)), timePerFrame: 0.1)
        let afterPowderAppearedAnimation = SKAction.animate(with: Array(theme.textures.suffix(from: 6)), timePerFrame: 0.1)
        let powderAnimation = SKAction.run {
            self.powderAnimationLayer.run(SKAction.animate(with: self.theme.powderTextures, timePerFrame: 0.1)){
                self.powderAnimationLayer.removeFromParent()
            }
        }
        
        let crashAnimation = SKAction.sequence([beforePowderAppearedAnimation,
                                                SKAction.group([afterPowderAppearedAnimation,
                                                                powderAnimation])])
        
        let removingAction = SKAction.run { [weak self] in
            completion?()
        }
        delay(0.3, closure: {
            self.getCoin()
        })
        
        run(SKAction.sequence([crashAnimation,SKAction.playSoundFileNamed("004-0.mp3", waitForCompletion: false), removingAction]))
    }
    
    func getCoin(){
        
        if let parentScene = self.scene as? GameScene{
            
            let candyToDollar = CandyToDollars()
            candyToDollar.dollar = price.priceInCoin
            self.addChild(candyToDollar)
            candyToDollar.isHidden = false
            
            candyToDollar.updateScoresCount()
            candyToDollar.beginAnimation()
            
            updateDollarsToGameData(price.priceInCoin)
            parentScene.dollarWallet.updateDollarsCount()
            
        }
        
        
    }
}
