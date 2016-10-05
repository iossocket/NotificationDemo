//
//  PermissionManager.swift
//  NotificationDemo
//
//  Created by XueliangZhu on 10/5/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//

import UIKit

class PermissionManager {
    class func registerNotificationSettings(application: UIApplication) {
        let acceptAction = UIMutableUserNotificationAction()
        acceptAction.identifier = "ACCEPT_IDENTIFIER"
        acceptAction.title = "Accept"
        acceptAction.activationMode = .background // if foreground, after tap this button, it will launch app, or just do something and dismiss that notification
        acceptAction.isDestructive = false // if it is true, this button will be red color.
        acceptAction.isAuthenticationRequired = false // when activationMode is background, and this value the false, this action do not need password, otherwise it need password to do this action.
        // but when activationMode is true, it always needs password to do this action.
        
        let denyAction = UIMutableUserNotificationAction()
        denyAction.identifier = "DENY_IDENTIFIER"
        denyAction.title = "Deny"
        denyAction.activationMode = .background
        denyAction.isDestructive = true
        denyAction.isAuthenticationRequired = false
        // use can input some thing by this action
        denyAction.behavior = .textInput
        
        let inviteCategory = UIMutableUserNotificationCategory()
        inviteCategory.identifier = "INVITE_CATEGORY"
        inviteCategory.setActions([acceptAction, denyAction], for: .default)
        
        let notificationSettings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: [inviteCategory])
        application.registerUserNotificationSettings(notificationSettings)
    }
}
