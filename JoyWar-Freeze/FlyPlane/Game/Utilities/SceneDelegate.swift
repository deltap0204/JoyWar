//
//  GameSceneNavigator.swift
//  FlyPlane
//
//  Created by Dexter on 05/05/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import UIKit

protocol SceneDelegate {
    
    
    // MARK: Properties
    
    var size: CGSize { get }
    
    
    // MARK: Actions
    
    func presentGameScene(_ isResuming: Bool)
    func presentFrontScene()
    
}
