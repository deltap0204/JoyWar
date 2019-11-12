//
//  Dictionary + Ext.swift
//  Game
//
//  Created by Dhanaraj Sindhu Bairavi on 25/02/18.
//  Copyright © 2018 Daniel Slupskiy. All rights reserved.
//

import Foundation

extension Dictionary where Value: Equatable {
    
    func keyForValue(value: Value) -> Key? {
        return first(where: { $1 == value })?.key
    }
    
}
