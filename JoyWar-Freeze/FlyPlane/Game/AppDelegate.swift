//
//  AppDelegate.swift
//  FlyPlane
//
//  Created by Dexter on 22/04/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import UIKit
import GoogleMobileAds
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ChartboostDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        StoreKitManager.shared.fetchProducts()
        
        Chartboost.start(withAppId: "5a7fdd9857a2dd0c33ebef0b",
                         appSignature: "8107e4766ed9ecfe260f516f8c9f2829f13f4b99",
                         delegate: self)
        Chartboost.setAutoCacheAds(true)
        
        //Rewarded Ad
        GADMobileAds.configure(withApplicationID: "ca-app-pub-3300136891339316/5157402034")
                
        if !isBonusGivenForOneTime {
            
            insertDollarsToGameData(0)
            updateDollarsToGameData(1500)
            
            PlayersBackpack.startupBonus()
            
            registerForLocalNotifications(application: application)
        }
        
        PlayersBackpack.loadFromStorage()
    
        return true
    }
    
    func registerForLocalNotifications(application: UIApplication) -> Void {
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
            
            guard granted else {
                
                return
            }
            
            LocalNotifications.setUpLocalNotification()
        }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        PlayersBackpack.saveToStorage()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        PlayersBackpack.saveToStorage()
    }
}

