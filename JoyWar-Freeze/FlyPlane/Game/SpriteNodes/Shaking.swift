//
//  Shaking.swift
//  Game
//
//  Created by Daniel Slupskiy on 03.05.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import Foundation

protocol Shaking {
    func beginShakeAnimation(withCompletion completion: (()->())?)
}
