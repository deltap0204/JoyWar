//
//  StoreTableViewCell.swift
//  Game
//
//  Created by Developer on 29.05.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import UIKit

class StoreTableViewCell: UITableViewCell {

    @IBOutlet weak var moneyButton: UIButton!

    @IBOutlet weak var productCounterLabel: UILabel!
   
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
