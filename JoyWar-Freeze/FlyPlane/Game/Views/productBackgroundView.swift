//
//  productBackgroundView.swift
//  Game
//
//  Created by Developer on 02.06.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import UIKit

class productBackgroundView: UIImageView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        self.image = #imageLiteral(resourceName: "Bar")
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.blue.cgColor
        self.layer.masksToBounds = true
    }
    

}
