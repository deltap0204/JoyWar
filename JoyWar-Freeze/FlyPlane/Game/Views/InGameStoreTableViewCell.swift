//
//  InGameStoreTableViewCell.swift
//  Game
//
//  Created by Dhanaraj Sindhu Bairavi on 03/03/18.
//  Copyright © 2018 Daniel Slupskiy. All rights reserved.
//

import UIKit

class InGameStoreTableViewCell: UITableViewCell {

    @IBOutlet weak var moneyButton: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var Coins100kSave75: UIImageView!
    @IBOutlet weak var Coins30kSave75: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        //animate forever
        animateWithDelay()
    }
    
    func animateWithDelay() -> Void {
        UIView.animate(withDuration: 0.20, delay: 1.0, options: [], animations: {
            
            UIView.setAnimationRepeatCount(3)
            
            self.moneyButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.priceLabel.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.moneyButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self.priceLabel.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self.moneyButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.priceLabel.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            
        }) { (success) in
            self.moneyButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.priceLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            
            self.animateWithDelay()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class MoneyLabel: UILabel {
    var productIdentifier: String?
}
