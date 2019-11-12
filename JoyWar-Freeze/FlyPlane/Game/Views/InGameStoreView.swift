//
//  InGameStoreView.swift
//  Game
//
//  Created by Dhanaraj Sindhu Bairavi on 02/03/18.
//  Copyright © 2018 Daniel Slupskiy. All rights reserved.
//

import Foundation
import SpriteKit

class InGameStoreView: UIView {
    
    @IBOutlet weak var productsTableview: UITableView!
    
    var type : StoreProductType?
    
    var scene: BaseScene?
    
    var productArray: Array<String> = [
        "com.gameclub.joywar.30000coins",
        "com.gameclub.joywar.100000coins"
    ]
    
    init(frame: CGRect, type: StoreProductType){
        self.type = type
        super.init(frame: frame)
    }
    
    init(){
        super.init(frame: CGRect(x:5,y:100,width:366,height:448))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        let nib = UINib(nibName: "InGameStoreTableViewCell", bundle: nil)
        productsTableview.register(nib, forCellReuseIdentifier: "InGameStoreCell")
        productsTableview.delegate = self
        productsTableview.dataSource = self
        
        productsTableview.reloadData()
        productsTableview.rowHeight = 70
        productsTableview.separatorStyle = .none
    }
    
    @IBAction func close(_ sender: Any) {
        
        guard let parentScene = self.scene else {
            return
        }
        
        self.removeFromSuperview()
        parentScene.inGameStore = nil
        
        parentScene.showGameStore(productType: self.type!)
    }
    
}

extension InGameStoreView : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier:"InGameStoreCell", for: indexPath) as! InGameStoreTableViewCell
        
        cell.backgroundColor = UIColor.clear
        cell.contentView.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        
        let productIdentifier = self.productArray[indexPath.row]
        let coins = ShopManager.ProductIdWithDollars[productIdentifier]
        let price = ShopManager.PriceForIdentifiers[productIdentifier]
        
        if indexPath.row == 0 {
            cell.Coins100kSave75.isHidden = true
            cell.Coins30kSave75.isHidden = true
        } else if indexPath.row == 1 {
            cell.Coins100kSave75.isHidden = true
            cell.Coins30kSave75.isHidden = false
        } else {
            cell.Coins100kSave75.isHidden = false
            cell.Coins30kSave75.isHidden = true
        }
        
        cell.productLabel.text = "\(coins ?? 10000)" + " Coins"
        
        cell.priceLabel.text = price
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let productIdentifier = self.productArray[indexPath.row]
        buyAction(productIdentifier: productIdentifier)
    }
    
    func buyAction(productIdentifier: String){
        
        guard self.type!.isPossibleToBuyMore() else { return }
        
        ShopManager.purchaseProduct(withIdentifier: productIdentifier) { (success) in
            
            guard success else { return }
            
            DispatchQueue.main.async {
                if let currentScene = self.scene as? FrontScene{
                    currentScene.dollarWallet.updateDollarsCount()
                } else if let currentScene = self.scene as? GameScene{
                    currentScene.dollarWallet.updateDollarsCount()
                }
            }
            
            self.close(productIdentifier)
        }
    }
    
}
