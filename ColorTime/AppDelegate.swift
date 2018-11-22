//
//  AppDelegate.swift
//  ColorTime
//
//  Created by Victoria Corrodi on 8/4/17.
//  Copyright © 2017 Olivia Corrodi. All rights reserved.
//

//
//  AppDelegate.swift
//  ColorTime
//
//  Created by Emily Erlichson on 5/27/17.
//  Copyright © 2017 Emily Erlichson. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print("Hello!")
        let notificationTypes: UIUserNotificationType = [UIUserNotificationType.alert, UIUserNotificationType.badge, UIUserNotificationType.sound]
        let pushNotificationSettings = UIUserNotificationSettings(types: notificationTypes, categories: nil)
        application.registerUserNotificationSettings(pushNotificationSettings)
        application.registerForRemoteNotifications()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        if UserDefaults.standard.dictionary(forKey: "alarms") != nil {
            var alarmSaver = UserDefaults.standard.dictionary(forKey: "alarms")
            for alarm in alarmSaver! {
            //                let dfHr = DateFormatter();
            //                dfHr.dateFormat = "h";
            //                let alarmHr = dfHr.string(from: alarm)
            //                print(alarmHr)
            //var intAlarm = round(alarm.timeIntervalSince1970)
            let currentTime = Calendar.current.date(from: DateComponents())
                if currentTime?.compare(alarm.value as! Date) == .orderedSame || currentTime?.compare(alarm.value as! Date) == .orderedAscending {
                    let notification = UILocalNotification()
                    notification.alertBody = alarm.key
                    notification.fireDate = currentTime
                }
                //self.isGoingOff = true
            }
        }
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        print("DEVICE TOKEN = \(deviceToken)")
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
    private func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        print(userInfo)
    }
    
}

