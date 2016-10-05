//
//  AppDelegate.swift
//  NotificationDemo
//
//  Created by XueliangZhu on 10/3/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { (success, error) in
                print(success)
                center.getNotificationSettings(completionHandler: { settings in
                    print(settings)
                })
            })
            
            
            let action = UNNotificationAction(identifier: "reply", title: "Reply", options: [.destructive])
            // this options is same as isDestructive in previous system version. and there are other options: authenticationRequired, foreground
            let input = UNTextInputNotificationAction(identifier: "input", title: "Input", options: [.destructive])
            let category = UNNotificationCategory(identifier: "message", actions: [action, input], intentIdentifiers: [], options: [])
            
            center.setNotificationCategories([category])
        } else {
            PermissionManager.registerNotificationSettings(application: application)
        }
        application.registerForRemoteNotifications()
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print(deviceTokenString)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        print(notificationSettings)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print(userInfo)
        completionHandler(UIBackgroundFetchResult.noData)
    }
    
    
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [AnyHashable : Any], completionHandler: @escaping () -> Void) {
        if identifier == "ACCEPT_IDENTIFIER" {
            print("Accept")
        }
        
        completionHandler()
    }
    
    // this delegate method just available in iOS9
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [AnyHashable : Any], withResponseInfo responseInfo: [AnyHashable : Any], completionHandler: @escaping () -> Void) {
        if identifier == "ACCEPT_IDENTIFIER" {
            print("Accept")
        } else if identifier == "DENY_IDENTIFIER" {
            let response = responseInfo[UIUserNotificationActionResponseTypedTextKey]
            print(response)
        }
        
        completionHandler()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        application.applicationIconBadgeNumber = 0
    }
}


@available(iOS 10.0, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print(notification.request.content.body)
        completionHandler([.alert]) // the paramters indicate how to present this notification when app is in foreground.
        // we can pass an emty array to this completionHandler, for presenting nothing.
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.actionIdentifier == "reply" {
            print("click reply")
        } else if response.actionIdentifier == "input" {
            let resp = response as! UNTextInputNotificationResponse
            print(resp.userText)
        }
        
        completionHandler()
    }
}

