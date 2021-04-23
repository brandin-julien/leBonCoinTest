//
//  AppDelegate.swift
//  leBonCoinTest
//
//  Created by julien brandin on 22/04/2021.
//  Copyright © 2021 julien brandin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Create a window that is the same size as the screen
        window = UIWindow(frame: UIScreen.main.bounds)
        // Create a view controller
        let viewController = ViewController()
        // Assign the view controller as `window`'s root view controller
        window?.rootViewController = viewController
        // Show the window
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
       }

       func applicationDidEnterBackground(_ application: UIApplication) {
       }

       func applicationWillEnterForeground(_ application: UIApplication) {
       }

       func applicationDidBecomeActive(_ application: UIApplication) {
       }

       func applicationWillTerminate(_ application: UIApplication) {
       }
    
}

