//
//  AppDelegate.swift
//  PokeMatch
//
//  Created by Allen Boynton on 5/22/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//
//  All content & design © Pokémon Database, 2008-2017. Pokémon images & names © 1995-2017 Nintendo/Game Freak.
//  https://pokemondb.net/about#privacy


import UIKit
import Firebase
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {granted, error in
                    
                if granted {
                    print("Notification access granted")
                } else {
                    print(error?.localizedDescription as Any)
                }
            })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
//        // Retrieve the current registration token
//        let token = Messaging.messaging().fcmToken
//        print("FCM token: \(token ?? "")")
//        
//        // Monitor token generation
//        func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
//            print("Firebase registration token: \(fcmToken)")
//        }
//        
//        // Provide your APNs token using the APNSToken property:
//        func application(application: UIApplication,
//                         didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
//            Messaging.messaging().apnsToken = deviceToken as Data
//        }
        
        // Asks permission to show notifications
        func askToShowVisibleNotifications() {
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { ( granted, error) in
                
            }
        }
        
//        // Swizzle - Build upon your own notifications
//        func swizzled_application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//            
//        }
//        
//        func swizzled_userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//            
//        }
//        
//        func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
//                         fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//            // If you are receiving a notification message while your app is in the background,
//            // this callback will not be fired till the user taps on the notification launching the application.
//            // TODO: Handle data of notification
//            
//            // With swizzling disabled you must let Messaging know about the message, for Analytics
//            Messaging.messaging().appDidReceiveMessage(userInfo)
//            
////            Messaging.messaging().sendMessage(message, to: to, withMessageID: messageId, timeToLive: ttl)
//            
//            // Print message ID.
//            if let messageID = userInfo["JDPYMY5287"] {
//                print("Message ID: \(messageID)")
//            }
//            
//            // Print full message.
//            print(userInfo)
//            
//            completionHandler(UIBackgroundFetchResult.newData)
//        }
//                
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
    }
}
