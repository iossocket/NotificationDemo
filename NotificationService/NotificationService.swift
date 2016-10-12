//
//  NotificationService.swift
//  NotificationService
//
//  Created by XueliangZhu on 10/5/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        let bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            bestAttemptContent.title = "\(bestAttemptContent.body) [modified]"
            contentHandler(bestAttemptContent)
        }
    }
    
    override func serviceExtensionTimeWillExpire() {

    }
}
