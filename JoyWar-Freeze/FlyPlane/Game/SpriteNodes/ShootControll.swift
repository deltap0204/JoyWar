//
//  ShootControll.swift
//  Game
//
//  Created by Daniel Slupskiy on 14.04.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import Foundation
import SpriteKit

class ShootControll: Button {
    
    // MARK: Properties
    
    var counter1stDigit = SKSpriteNode(imageNamed: "Digit0")
    var counter2ndDigit = SKSpriteNode(imageNamed: "Digit0")
    var counter3rdDigit = SKSpriteNode(imageNamed: "Digit0")
    
    let imageTexture = SKTexture(image: #imageLiteral(resourceName: "Shooting button"))
    
    var timer = ProgressNode()
    
    // MARK: Lifecycle
    
    init() {
        super.init(texture: imageTexture,
                   color: UIColor(),
                   size: CGSize(width: 54.5,//imageTexture.size().width / 4,
                                height: 54.5))//imageTexture.size().height / 4))
        
        createCounter()
        createTimer()
        updateCounter(with: PlayersBackpack.bulletsCount)//50)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Actions
    
    override func beginAnimation() {
       
        let scale1By1 = SKAction.scale(to: 1.0, duration: 0.0416)
        let scale3By4 = SKAction.scale(to: 0.90, duration: 0.0416)
        let scale1By2 = SKAction.scale(to: 0.75, duration: 0.0416)
        let scaleSequence = SKAction.sequence([scale3By4, scale1By2, scale3By4, scale1By1])
        run(SKAction.repeatForever(scaleSequence))
    }
    
    func endAnimation() {
        setScale(1)
        removeAllActions()
    }
    
    func createCounter() {
        
        let digitSize = CGSize(width: counter1stDigit.size.width / 12, height: counter1stDigit.size.height / 12)
        let digitXBase = position.x + size.width/2
        let digitY = position.y - size.height/2 - 12 + counter1stDigit.size.height / 16
        counter1stDigit.size = digitSize
        counter1stDigit.position = CGPoint(x: digitXBase - counter1stDigit.size.width, y: digitY)
        counter1stDigit.isHidden = true
        addChild(counter1stDigit)
        
        counter2ndDigit.size = digitSize
        counter2ndDigit.position = CGPoint(x: digitXBase, y: digitY)
        counter2ndDigit.isHidden = true
        addChild(counter2ndDigit)
        
        counter3rdDigit.size = digitSize
        counter3rdDigit.position = CGPoint(x: digitXBase + counter3rdDigit.size.width, y: digitY)
        counter3rdDigit.isHidden = true
        addChild(counter3rdDigit)
    }
    
    func createTimer() {
        
        timer.radius = 30
        timer.width = 5.0
        timer.color = SKColor.green
        timer.backgroundColor = SKColor.clear
        timer.position = CGPoint(x: frame.midX, y: frame.midY)
        timer.isHidden = true
        addChild(timer)
    }
    
    func updateCounter(with value: Int) {
        
        PlayersBackpack.bulletsCount = value
        let symbols = String(value)
        
        counter1stDigit.isHidden = true
        counter2ndDigit.isHidden = true
        counter3rdDigit.isHidden = true
        
        
        switch symbols.characters.count {
        case 1:
            counter1stDigit.isHidden = false
            counter1stDigit.texture = SKTexture(imageNamed: symbols[0])
            break
        case 2:
            counter1stDigit.isHidden = false
            counter1stDigit.texture = SKTexture(imageNamed: symbols[0])
            counter2ndDigit.isHidden = false
            counter2ndDigit.texture = SKTexture(imageNamed: symbols[1])
            break
        case 3:
            counter1stDigit.isHidden = false
            counter1stDigit.texture = SKTexture(imageNamed: symbols[0])
            counter2ndDigit.isHidden = false
            counter2ndDigit.texture = SKTexture(imageNamed: symbols[1])
            counter3rdDigit.isHidden = false
            counter3rdDigit.texture = SKTexture(imageNamed: symbols[2])
            break
        default:
            break
        }
        
        beginDigitsAnimation()
    }
    
    func beginDigitsAnimation() {
        let scale1 = SKAction.scale(to: 1.0, duration: 0.05)
        let scale2 = SKAction.scale(to: 0.90, duration: 0.05)
        let scale3 = SKAction.scale(to: 0.75, duration: 0.05)
        let scale4 = SKAction.scale(to: 0.90, duration: 0.05)
        let scale5 = SKAction.scale(to: 1.0, duration: 0.05)
        let scale6 = SKAction.scale(to: 1.25, duration: 0.2)
        let scale7 = SKAction.scale(to: 1.0, duration: 0.2)
        
        let scaleSequence = SKAction.sequence([scale1, scale2, scale3, scale4, scale5, scale6,scale7])
        counter1stDigit.run(scaleSequence)
        counter2ndDigit.run(scaleSequence)
        counter3rdDigit.run(scaleSequence)
    }
    
    override func beginBubbleAnimation() {
        let scale1By1 = SKAction.scale(to: 1.0, duration: 0.20)
        let scale3By4 = SKAction.scale(to: 0.9, duration: 0.10)
        let scale1By3 = SKAction.scale(to: 1.0, duration: 0.10)
        let scale1By2 = SKAction.scale(to: 0.8, duration: 0.10)
        let wait = SKAction.wait(forDuration: 1.0)
        let scaleSequence =  SKAction.repeatForever(SKAction.sequence([scale3By4, scale1By2, scale1By3, scale3By4, scale1By1, wait]))
        run(scaleSequence)
    }
}



// MARK: PlaneMachineGunDelegate

extension ShootControll: PlaneMachineGunDelegate {
    func updateBullets(count: Int) {
        updateCounter(with: count)
    }
    func startReloadCountdown(duration: Double) {
        timer.isHidden = false
        timer.countdown(time: 10.0) { [weak self] () -> Void in
            self?.timer.isHidden = true
            self?.updateCounter(with: 50)
        }
    }
}
