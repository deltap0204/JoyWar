//
//  LocalNotifications.swift
//  Game
//
//  Created by Dhanaraj Sindhu Bairavi on 18/02/18.
//  Copyright © 2018 Daniel Slupskiy. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotifications {
    
    /// Set up the local notification for everyday
    /// - parameter hour: The hour in 24 of the day to trigger the notification
    static func setUpLocalNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "Joywar: Xtreme Candy Powers"
        content.body = "BULLETS & ROCKETS are waiting! Get back into the action and begin some candy destruction!!"
        content.categoryIdentifier = "getGamerToGameWithoutRewarded"
        
        //Date component trigger
        var dateComponents = DateComponents()
        
        // a more realistic example for Gregorian calendar. Every Monday at 11:30AM
        dateComponents.hour = 10
        dateComponents.minute = 6
        dateComponents.second = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                //print("error: \(error.localizedDescription)")
            }
        }
        
    }    
}
