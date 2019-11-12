//
//  GS - Chartboost.swift
//  Game
//
//  Created by Developer on 13.07.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import Foundation
import GoogleMobileAds

extension GameScene: ChartboostDelegate{

    //- (void)didDisplayInterstitial:(CBLocation)location
    func didDisplayInterstitial(_ location: String!) {
        waitingForAdv = false
    }

}

extension GameScene: GADBannerViewDelegate{
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView!) {
        //print("Banner loaded successfully")
        //tableView.tableHeaderView?.frame = bannerView.frame
        //tableView.tableHeaderView = bannerView
        
    }
    
    
    func adView(_ bannerView: GADBannerView!, didFailToReceiveAdWithError error: Any!) {
        //print("Fail to receive ads")
        //print(error)
    }
}
