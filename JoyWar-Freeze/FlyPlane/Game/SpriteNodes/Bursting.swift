//
//  Bursting.swift
//  Game
//
//  Created by Daniel Slupskiy on 10.04.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import Foundation

protocol Bursting {
    func beginBurstAnimation(withCompletion completion: (()->())?)
}
