//
//  GameSceneNavigator.swift
//  FlyPlane
//
//  Created by Dexter on 05/05/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation

protocol PresentGameScene {
    func presentGameScene(isResuming: Bool)
    func presentFrontScene()
}