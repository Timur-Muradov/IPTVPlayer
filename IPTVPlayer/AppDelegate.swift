//
//  AppDelegate.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 01.12.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let dataSource = DataSourceBuilder.buildDataSource()
        let rootViewController = window?.rootViewController as? ChannelsListViewController
        rootViewController?.dataSource = dataSource
        return true
    }
}

