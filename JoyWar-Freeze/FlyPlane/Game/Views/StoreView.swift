//
//  StoreView.swift
//  Game
//
//  Created by Developer on 02.06.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import UIKit
import SpriteKit

enum StoreProductType: String{
    
    case bubble = "Bubble"
    case bullet = "Bullet"
    case balloon = "Balloon"
    case pathFinder = "PathFinder"
    case rocketType1 = "RocketType1"
    case rocketType2 = "RocketType2"
    case rocketType3 = "RocketType3"
    case rocketType4 = "RocketType4"
    case rocketType5 = "RocketType5"
    case none = "none"
    
    func getIndex() -> Int {
        switch self {
        case .bubble: return 0
        case .bullet: return 1
        case .balloon: return 2
        case .pathFinder: return 3
        case .rocketType1: return 4
        case .rocketType2: return 5
        case .rocketType3: return 6
        case .rocketType4: return 7
        case .rocketType5: return 8
        case .none: return -1
        }
    }
    
    func getImage() -> UIImage {
        switch self {
        case .bubble: return #imageLiteral(resourceName: "bubble-256px")
        case .bullet: return #imageLiteral(resourceName: "Shooting button")
        case .balloon: return #imageLiteral(resourceName: "BalloonControl")
        case .pathFinder: return #imageLiteral(resourceName: "PathfinderControl")
        case .rocketType1: return #imageLiteral(resourceName: "Type1")
        case .rocketType2: return #imageLiteral(resourceName: "Type2")
        case .rocketType3: return #imageLiteral(resourceName: "Type3")
        case .rocketType4: return #imageLiteral(resourceName: "Type4")
        case .rocketType5: return #imageLiteral(resourceName: "Type5")
        case .none: return UIImage()
        }
    }
    
    func getProductArray() -> Array<(productCount: Int, price: Int, id: String)> {
        var productPriceArray = Array<(productCount: Int, price: Int, id: String)>()
        let productCountArray: Array<Int>
        let priceArray: Array<Int>
        switch self {
        case .bubble:
            productCountArray = [5, 9, 18]
            priceArray = [1000, 2600, 4200]
            for i in 0..<productCountArray.count{
                let identifier = "com.gameclub.joywar." + "bubbleOption\(i + 1)"
                productPriceArray.append((productCount: productCountArray[i], price: priceArray[i], id: identifier))
            }
        case .bullet:
            productCountArray = [50, 150, 300]
            priceArray = [500, 1300, 2100]
            for i in 0..<productCountArray.count{
                let identifier = "com.gameclub.joywar." + "bulletOption\(i + 1)"
                productPriceArray.append((productCount: productCountArray[i], price: priceArray[i], id: identifier))
            }
        case .balloon:
            productCountArray = [3, 9, 18]
            priceArray = [1500, 3000, 5000]
            for i in 0..<productCountArray.count{
                let identifier = "com.gameclub.joywar." + "balloonOption\(i + 1)"
                productPriceArray.append((productCount: productCountArray[i], price: priceArray[i], id: identifier))
            }
        case .pathFinder:
            productCountArray = [3, 9, 18]
            priceArray = [500, 1300, 2100]
            for i in 0..<productCountArray.count{
                let identifier = "com.gameclub.joywar." + "pathFinderOption\(i + 1)"
                productPriceArray.append((productCount: productCountArray[i], price: priceArray[i], id: identifier))
            }
        case .rocketType1:
            productCountArray = [3, 9, 18]
            priceArray = [1000, 2300, 4000]
            for i in 0..<productCountArray.count{
                let identifier = "com.gameclub.joywar." + "rocketType1Option\(i + 1)"
                productPriceArray.append((productCount: productCountArray[i], price: priceArray[i], id: identifier))
            }
        case .rocketType2:
            productCountArray = [3, 9, 18]
            priceArray = [1100, 2500, 4200]
            for i in 0..<productCountArray.count{
                let identifier = "com.gameclub.joywar." + "rocketType2Option\(i + 1)"
                productPriceArray.append((productCount: productCountArray[i], price: priceArray[i], id: identifier))
            }
        case .rocketType3:
            productCountArray = [3, 9, 18]
            priceArray = [1300, 2700, 4400]
            for i in 0..<productCountArray.count{
                let identifier = "com.gameclub.joywar." + "rocketType3Option\(i + 1)"
                productPriceArray.append((productCount: productCountArray[i], price: priceArray[i], id: identifier))
            }
        case .rocketType4:
            productCountArray = [3, 9, 18]
            priceArray = [1500, 2900, 4500]
            for i in 0..<productCountArray.count{
                let identifier = "com.gameclub.joywar." + "rocketType4Option\(i + 1)"
                productPriceArray.append((productCount: productCountArray[i], price: priceArray[i], id: identifier))
            }
        case .rocketType5:
            productCountArray = [3, 9, 18]
            priceArray = [1700, 3000, 4700]
            for i in 0..<productCountArray.count{
                let identifier = "com.gameclub.joywar." + "rocketType5Option\(i + 1)"
                productPriceArray.append((productCount: productCountArray[i], price: priceArray[i], id: identifier))
            }
        default:
            break

        }
        return productPriceArray
    }
    
    func isPossibleToBuyMore() -> Bool {
        switch self{
        case .bubble: return PlayersBackpack.bubblesCount < 999
        case .bullet: return PlayersBackpack.bulletsCount < 999
        case .balloon: return PlayersBackpack.balloonCount < 999
        case .pathFinder: return PlayersBackpack.pathFinderCount < 999
        case .rocketType1: return PlayersBackpack.rocketsCount[.type1]! < 999
        case .rocketType2: return PlayersBackpack.rocketsCount[.type2]! < 999
        case .rocketType3: return PlayersBackpack.rocketsCount[.type3]! < 999
        case .rocketType4: return PlayersBackpack.rocketsCount[.type4]! < 999
        case .rocketType5: return PlayersBackpack.rocketsCount[.type5]! < 999
        case .none: return true
        default:
            return false
        }
    }
    
    func buyAmmo(count : Int, price: Int){
        
        guard isPossibleToBuyMore() else { return }
        
        switch self{
        case .bubble:
            PlayersBackpack.bubblesCount += count
            if PlayersBackpack.bubblesCount > 999 {
                PlayersBackpack.bubblesCount = 999
            }
        case .bullet:
            PlayersBackpack.bulletsCount += count
            if PlayersBackpack.bulletsCount > 999 {
                PlayersBackpack.bulletsCount = 999
            }
        case .balloon:
            PlayersBackpack.balloonCount += count
            if PlayersBackpack.balloonCount > 999 {
                PlayersBackpack.balloonCount = 999
            }
        case .pathFinder:
            PlayersBackpack.pathFinderCount += count
            if PlayersBackpack.pathFinderCount > 999 {
                PlayersBackpack.pathFinderCount = 999
            }
        case .rocketType1:
            PlayersBackpack.rocketsCount[.type1]! += count
            if PlayersBackpack.rocketsCount[.type1]! > 999 {
                PlayersBackpack.rocketsCount[.type1] = 999
            }
        case .rocketType2:
            PlayersBackpack.rocketsCount[.type2]! += count
            if PlayersBackpack.rocketsCount[.type2]! > 999 {
                PlayersBackpack.rocketsCount[.type2] = 999
            }
        case .rocketType3:
            PlayersBackpack.rocketsCount[.type3]! += count
            if PlayersBackpack.rocketsCount[.type3]! > 999 {
                PlayersBackpack.rocketsCount[.type3] = 999
            }
        case .rocketType4:
            PlayersBackpack.rocketsCount[.type4]! += count
            if PlayersBackpack.rocketsCount[.type4]! > 999 {
                PlayersBackpack.rocketsCount[.type4] = 999
            }
        case .rocketType5:
            PlayersBackpack.rocketsCount[.type5]! += count
            if PlayersBackpack.rocketsCount[.type5]! > 999 {
                PlayersBackpack.rocketsCount[.type5] = 999
            }
        default:
            break
        }
        
        updateDollarsToGameData(-price)
    }
    
    func getDescription()->String{
        switch self{
        case .bubble: return "Use Bubble to fire or animate everything in its way and safely fly through all the hurdles and enemies! Even blockers!!"
        case .bullet: return "Shoot bullets and kill all the enemies and hurdles on its way!"
        case .balloon: return "Attractive aircraft balloon automatically takes you to safely fly through the hurdles without getting out!"
        case .pathFinder: return "Hint gives you the next safe path to safely fly through the hurdles without getting out!"
        case .rocketType1: return "Destroys one hurdle or enemy on its way!"
        case .rocketType2: return "Destroys two hurdles or enemies subsequently on its way!"
        case .rocketType3: return "Destroys two hurdles or enemies subsequently on its way! Automatically finds second hurdle or enemy and destroys it!!"
        case .rocketType4: return "Destroys two hurdles or enemies subsequently on its way with Jelly animation! Automatically finds second hurdle or enemy and destroys it!!"
        case .rocketType5: return "Destroys all the hurdles and enemies on its way!!!"
        default:
            return ""
        }
    }
    
    var isLeftButtonEnabled: Bool{
        switch self {
        case .bubble: return false
        case .bullet: return false
        case .balloon: return false
        case .pathFinder: return false
        case .rocketType1: return true
        case .rocketType2: return true
        case .rocketType3: return true
        case .rocketType4: return true
        case .rocketType5: return true
        default:
            return false
        }
    }
    
    var isRightButtonEnabled: Bool{
        switch self {
        case .bubble: return false
        case .bullet: return false
        case .balloon: return false
        case .pathFinder: return false
        case .rocketType1: return true
        case .rocketType2: return true
        case .rocketType3: return true
        case .rocketType4: return true
        case .rocketType5: return true
        default:
            return false
        }
    }
    
    func getNext() -> StoreProductType {
        
        switch self {
        case .rocketType1:
            return .rocketType2
        case .rocketType2:
            return .rocketType3
        case .rocketType3:
            return .rocketType4
        case .rocketType4:
            return .rocketType5
        case .rocketType5:
            return .rocketType1
        default: return .rocketType1
        }
        
    }
    
    func getPrevious() -> StoreProductType {
        
        switch self {
        case .rocketType1:
            return .rocketType5
        case .rocketType2:
            return .rocketType1
        case .rocketType3:
            return .rocketType2
        case .rocketType4:
            return .rocketType3
        case .rocketType5:
            return .rocketType4
            default: return .rocketType1
        }
    }
    
   static func rocketTypeForIndex(index: Int)-> StoreProductType{
    switch index{
    case 0: return .rocketType1
    case 1: return .rocketType2
    case 2: return .rocketType3
    case 3: return .rocketType4
    case 4: return .rocketType5
    default: return .rocketType1
    }
    
    }


    
    }

class StoreView: UIView {
    @IBOutlet weak var productBackgroundImageView: UIImageView!

    //@IBOutlet weak var horizontalScroller: HorizontalScroller!
    
   
    @IBOutlet weak var scrollView: InfiniteScrollView!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var storeTableView: UITableView!
    var type : StoreProductType
    var productArray : Array<(productCount: Int, price: Int, id: String)>
    var rocketImageViewArray = Array<UIImageView>()
    
    var colors:[UIColor] = [UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow]
    var newFrame: CGRect = CGRect(x:0, y:0, width:0, height:0)
    
    var scene: BaseScene?
    
    init(frame: CGRect, type: StoreProductType){
        self.type = type
        self.productArray = self.type.getProductArray()
        
        super.init(frame: frame)
    }
    
    init(){
    self.type = .bubble
    self.productArray = self.type.getProductArray()
    super.init(frame: CGRect(x:5,y:100,width:366,height:448))
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.type = .bubble
        self.productArray = self.type.getProductArray()
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        let nib = UINib(nibName: "StoreTableViewCell", bundle: nil)
        storeTableView.register(nib, forCellReuseIdentifier: "storeCell")
        storeTableView.delegate = self
        storeTableView.dataSource = self
        
        
        if self.type == .rocketType1 || self.type == .rocketType2 || self.type == .rocketType3 || self.type == .rocketType4 || self.type == .rocketType5{
        
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        
        var currentRocketType = StoreProductType.rocketType1
        rocketImageViewArray = Array<UIImageView>()
        for index in 0..<6 {
            
            
            newFrame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
            newFrame.size = self.scrollView.frame.size
            
            
            
            let subImageView = UIImageView(frame: newFrame)
            
            let animationArray = RocketType(rawValue: currentRocketType.rawValue)?.getImageForStore()
            
            
            subImageView.animationImages = animationArray;
            subImageView.animationDuration = 0.9
            subImageView.startAnimating()
            subImageView.contentMode = .scaleAspectFit
            rocketImageViewArray.append(subImageView)
            
            self.scrollView .addSubview(rocketImageViewArray[index])
            currentRocketType = currentRocketType.getNext()
            
        }
        
        self.scrollView.contentSize = CGSize(width:self.scrollView.frame.size.width * 6,height: self.scrollView.frame.size.height)
       
        
        let index: Int = RocketType(rawValue: self.type.rawValue)!.getNumberOfType()-1
        
            self.scrollView.scrollToView(view: self.rocketImageViewArray[index], animated: true)
        }
       
            storeTableView.rowHeight = 70
       
        storeTableView.separatorStyle = .none
        
        setUI()
        for case let x as UIScrollView in self.storeTableView.subviews {
            x.delaysContentTouches = false
        }
        
    }
    
    
    func setUI(){
        storeTableView.reloadData()
        if self.type == .rocketType1 || self.type == .rocketType2 || self.type == .rocketType3 || self.type == .rocketType4 || self.type == .rocketType5{
            
            self.scrollView.isHidden = false
        }
        else{
        productBackgroundImageView.image = type.getImage()
            self.productBackgroundImageView.isHidden = false
        }
        
        
        leftButton.isHidden = !type.isLeftButtonEnabled
        rightButton.isHidden = !type.isRightButtonEnabled
        self.descriptionLabel.text = type.getDescription()
        
    }
    
    @IBAction func toLeft(_ sender: Any) {
        self.type = type.getPrevious()
        let index: Int = RocketType(rawValue: self.type.rawValue)!.getNumberOfType()-1
        
        Plane.currentRocketType = RocketType(rawValue: "RocketType\(index+1)")!
        if let currentScene = self.scene as? GameScene {
            currentScene.rocketIndicator.updateCounter(with: PlayersBackpack.rocketsCount[Plane.currentRocketType]!)
            currentScene.plane.rocketDelegate?.updateRockets(count: PlayersBackpack.rocketsCount[Plane.currentRocketType]!)
            currentScene.rocketIndicator.texture = SKTexture(image: Plane.currentRocketType.getIndicatorImage())
        } else if let currentScene = self.scene as? FrontScene {
            currentScene.rocketIndicator.updateCounter(with: PlayersBackpack.rocketsCount[Plane.currentRocketType]!)
            currentScene.plane.rocketDelegate?.updateRockets(count: PlayersBackpack.rocketsCount[Plane.currentRocketType]!)
            currentScene.rocketIndicator.texture = SKTexture(image: Plane.currentRocketType.getIndicatorImage())
        }
        self.scrollView.scrollToView(view: self.rocketImageViewArray[index], animated: true)
        
        setUI()
    }
    @IBAction func toRight(_ sender: Any) {
        self.type = type.getNext()
        let index: Int = RocketType(rawValue: self.type.rawValue)!.getNumberOfType()-1
        
        Plane.currentRocketType = RocketType(rawValue: self.type.rawValue)!
        if let currentScene = self.scene as? GameScene {
            currentScene.rocketIndicator.updateCounter(with: PlayersBackpack.rocketsCount[Plane.currentRocketType]!)
            currentScene.plane.rocketDelegate?.updateRockets(count: PlayersBackpack.rocketsCount[Plane.currentRocketType]!)
            currentScene.rocketIndicator.texture = SKTexture(image: Plane.currentRocketType.getIndicatorImage())
        } else if let currentScene = self.scene as? FrontScene {
            currentScene.rocketIndicator.updateCounter(with: PlayersBackpack.rocketsCount[Plane.currentRocketType]!)
            currentScene.plane.rocketDelegate?.updateRockets(count: PlayersBackpack.rocketsCount[Plane.currentRocketType]!)
            currentScene.rocketIndicator.texture = SKTexture(image: Plane.currentRocketType.getIndicatorImage())
        }
        
        self.scrollView.scrollToView(view: self.rocketImageViewArray[index], animated: true)
        setUI()
    }

    @IBAction func closeAction(_ sender: Any) {
        self.removeFromSuperview()
        if let currentScene = self.scene as? GameScene{
            currentScene.sceneResume()
        }
        if let currentScene = self.scene as? FrontScene{
            currentScene.store = nil
        }
    }
}

extension StoreView: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"storeCell", for: indexPath) as! StoreTableViewCell
        
        cell.backgroundColor = UIColor.clear
        cell.contentView.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        cell.productImage.image = self.type.getImage()
        cell.productCounterLabel.text = "x\(self.type.getProductArray()[indexPath.row].productCount)"
        cell.moneyAmount.text = "\(self.type.getProductArray()[indexPath.row].price)"
        cell.moneyButton.tag = indexPath.row
        cell.moneyButton.productIdentifier = ShopManager.ProductIdWithDollars.keyForValue(value: self.type.getProductArray()[indexPath.row].price)
        cell.moneyButton.addTarget(self, action:#selector(buyAction(sender:)), for: .touchUpInside)
        return cell
    }
    
    func buyAction(sender: MoneyButton){
        guard self.type.isPossibleToBuyMore() else { return }
        
        if getDollarsFromGameData() >= self.productArray[sender.tag].price{
            self.type.buyAmmo(count: self.productArray[sender.tag].productCount,
                              price: self.productArray[sender.tag].price)
            
            if let currentScene = self.scene as? FrontScene{
                currentScene.dollarWallet.updateDollarsCount()
                currentScene.updateCounterWithId(type.getIndex())
            } else if let currentScene = self.scene as? GameScene{
                currentScene.dollarWallet.updateDollarsCount()
                currentScene.updateCounterWithId(type.getIndex())
            }
            
        } else {
            
            //print("Identifier: " + sender.productIdentifier!)
            self.scene?.showInGameStore(productType: self.type, triedProduct: sender.productIdentifier!)
        }
    }
}



extension StoreView: UIScrollViewDelegate{
  
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView{
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        //print(pageNumber)
        self.type = StoreProductType.rocketTypeForIndex(index: Int(pageNumber))
        setUI()
          //  pageControl.currentPage = Int(pageNumber)
        }
    }

}
