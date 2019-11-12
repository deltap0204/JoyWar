//
//  FS - UITableViewDelegate.swift
//  Game
//
//  Created by Developer on 29.05.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

extension FrontScene: UITableViewDelegate, UITableViewDataSource{
    func showStoreTableView(){
        
        let viewFromNib: StoreView = Bundle.main.loadNibNamed("StoreView",
                                                            owner: nil,
                                                            options: nil)?.first as! StoreView
        viewFromNib.type = .bullet
        viewFromNib.productArray = viewFromNib.type.getProductArray()
        viewFromNib.frame = CGRect(x:5,y:100,width:285,height:461)
        viewFromNib.center = CGPoint(x: self.scene!.view!.frame.width/2, y: self.scene!.view!.frame.height/2)
        viewFromNib.scene = self
        
        self.scene?.view?.addSubview(viewFromNib)
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"storeCell", for: indexPath) as! StoreTableViewCell
        cell.backgroundColor = UIColor.clear
        cell.contentView.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        return cell
    }

}
