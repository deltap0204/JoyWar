//
//  Crashable.swift
//  Game
//
//  Created by Daniel Slupskiy on 07.04.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import Foundation

protocol Crashable {
    func beginCrashAnimation(withCompletion completion: (()->())?)
}
