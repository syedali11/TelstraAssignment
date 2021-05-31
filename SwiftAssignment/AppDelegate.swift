//
//  AppDelegate.swift
//  SwiftAssignment
//
//  Created by Syed Tariq Ali on 31/05/21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = themeNavTitleColor
        window?.makeKeyAndVisible()
        
        let viewController = ViewController()
        let navViewController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navViewController
        
        UINavigationBar.appearance().barTintColor = themeColor
        UINavigationBar.appearance().tintColor = themeNavTitleColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:themeNavTitleColor]
        
        return true
    }
}
