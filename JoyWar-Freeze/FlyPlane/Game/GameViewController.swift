//
//  GameViewController.swift
//  FlyPlane
//
//  Created by Dexter on 22/04/16.
//  Copyright (c) 2016 Studio2Entertainment. All rights reserved.
//

import UIKit
import SpriteKit
import Social
import GameKit
import GoogleMobileAds

class GameViewController: UIViewController, SceneDelegate {
    
    
    // MARK: Properties
    
    var size: CGSize {
        return (view as! SKView).bounds.size
    }
    
    
    lazy var adBannerView: GADBannerView = {
        let adBannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        adBannerView.adUnitID = "ca-app-pub-3300136891339316/3289431379"
        adBannerView.delegate = self
        adBannerView.rootViewController = self
        return adBannerView
    }()
    
    var gcEnabled = Bool()
    var gcDefaultLeaderBoard = String()
    var gameScene: GameScene?
    static var gameSceneForScreen: GameScene?
   // var gameScene: BaseScene? = nil
    
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        presentFrontScene()
        //authenticateLocalPlayer()
        adBannerView.load(GADRequest())
    }
    
    
    // MARK: Actions
    
    func presentGameScene(_ isResuming: Bool) {
        if gameScene != nil{
            for child in gameScene!.children{
                child.removeAllChildren()
                child.removeAllActions()
            }
            gameScene!.removeAllChildren()
            gameScene!.removeAllActions()
            gameScene!.setupProperties()
        }
        //else {
        //    AudioPlayer.startGameSceneBackgroundMusic()
        //}
        GameViewController.gameSceneForScreen = nil
        if let scene = GameScene(fileNamed: "GameScene") {// gameScene { //
            // Configure the view.
            
            let skView = self.view as! GameSceneView
        
            
//            skView.showsFPS = true
//            skView.showsNodeCount = true
            skView.showsPhysics = false
//            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = false
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            scene.isTheGamePaused = isResuming
           // if isResuming {
            
           // }
            scene.protocolDelegate = self
            scene.viewController = self
            
            scene.createControls()
            
            gameScene = scene
            GameViewController.gameSceneForScreen = scene
            
            let transition = SKTransition.fade(withDuration: 0.0)
            skView.presentScene(scene, transition: transition)
            
        }
    }
    
    func presentFrontScene() {
        if let scene = FrontScene(fileNamed: "GameScene") {
            
            
            AudioPlayer.shared.startFrontSceneBackgroundMusic()
            
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            //skView.showsPhysics = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = false
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            scene.protocolDelegate = self
            scene.viewController = self
            
            
            let transition = SKTransition.fade(withDuration: 0.0)
            skView.presentScene(scene, transition: transition)
        }
    }
    
    

    override var shouldAutorotate : Bool {
        return true
    }

    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
}


extension GameViewController: GKGameCenterControllerDelegate {
    func authenticateLocalPlayer() {
        let localPlayer: GKLocalPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = { [weak self] (ViewController, error) -> Void in
            if((ViewController) != nil) {
                self?.present(ViewController!, animated: true, completion: nil)
            } else if (localPlayer.isAuthenticated) {
                self?.gcEnabled = true
                
                localPlayer.loadDefaultLeaderboardIdentifier(completionHandler: { (leaderboardIdentifer, error) in
                    if error != nil {
                        //print(error ?? "Unknown error")
                    } else {
                        self?.gcDefaultLeaderBoard = leaderboardIdentifer!
                    }
                })
                
            } else {
                self?.gcEnabled = false
                //print("Local player could not be authenticated!")
                //print(error ?? "Unknown error")
            }
        }
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        
    }
}

// MARK: Social

extension GameViewController {
    func shareOnTwitter(scene:SKScene, score: Int?) {
        
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            let twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            var text = "Check out my score on Fly Plane: "
            if let score = score {
                text += "\(score)"
            } else {
                text += "\(GameHighScore)"
            }
            text += ". Can you beat it?"
            twitterSheet.setInitialText(text)
            twitterSheet.add(getScreenshot(scene: scene))
            present(twitterSheet, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Not logged in", message: "You need to be logged into the Twitter app in order to share Flyplane game to Twitter. Please log into the Twitter app and try again!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func shareOnFacebook(scene:SKScene, score:Int?) {
        
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) {
            let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            var text = "Check out my score on Fly Plane: "
            if let score = score {
                text += "\(score)"
            } else {
                text += "\(GameHighScore)"
            }
            text += ". Can you beat it?"
            facebookSheet.setInitialText(text)
            facebookSheet.add(getScreenshot(scene: scene))
            present(facebookSheet, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Not logged in", message: "You need to be logged into the Facebook app in order to share Flyplane game to Facebook. Please log into the Facebook app and try again!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func getScreenshot(scene: SKScene) -> UIImage {
        
        
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        
        view.drawHierarchy(in: self.view.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        
        return image
        
    }
    
    static func getBluredScreenshot(ofScene scene: SKScene) -> SKSpriteNode{
        
     
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: scene.view!.frame.size.width, height: scene.view!.frame.size.height), true, 1)
        scene.view!.drawHierarchy(in: scene.view!.frame, afterScreenUpdates: true)
        
        let context = UIGraphicsGetCurrentContext()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        let ciContext = CIContext(options: nil)
        let coreImage = CIImage(image: image!)
        let filter = CIFilter(name: "CIGaussianBlur")
        filter?.setValue(coreImage, forKey: kCIInputImageKey)
        filter?.setValue(3, forKey: kCIInputRadiusKey)
        let filteredImageData = filter?.value(forKey: kCIOutputImageKey) as! CIImage
        let filteredImageRef = ciContext.createCGImage(filteredImageData, from: filteredImageData.extent)
        let filteredImage = UIImage(cgImage: filteredImageRef!)
        
        let texture = SKTexture(image: filteredImage)
        let sprite = SKSpriteNode(texture:texture)
        
        sprite.position = CGPoint(x: scene.frame.midX, y: scene.frame.midY)
        
        return sprite
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if let baseScene = self.gameScene{
            baseScene.changeStorePositionOnRotation()
        }

        coordinator.notifyWhenInteractionEnds { context in
            if let baseScene = self.gameScene{
                baseScene.changeStorePositionOnRotation()
            }
            if !context.isCancelled {
                //Transition is done!
            }
           
        }
    }
    

    
}

extension GameViewController: GADBannerViewDelegate{
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView!) {
        //print("Banner loaded successfully")
        bannerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width - 60, height: 60)
        self.view.addSubview(bannerView)
        bannerView.center.x = self.view.center.x
        bannerView.isHidden = true
        
    }
    
    
    func adView(_ bannerView: GADBannerView!, didFailToReceiveAdWithError error: Any!) {
        //print("Fail to receive ads")
        //print(error)
    }
}

