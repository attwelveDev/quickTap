//
//  AppDelegate.swift
//  Tap
//
//  Created by Aaron Nguyen on 13/11/16.
//  Copyright © 2016 Aaron Nguyen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true
        
        let urlForCloud = FileManager.default.url(forUbiquityContainerIdentifier: nil)
        if urlForCloud == nil {
            print("No iCloud on device")
        } else {
            let store = NSUbiquitousKeyValueStore.default
            
            NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.iCloudKeysChanged(_:)), name: NSUbiquitousKeyValueStore.didChangeExternallyNotification, object: store)
            
            store.synchronize()
        }
        
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "isFirstTime") == nil {
            defaults.set("No", forKey:"isFirstTime")
            defaults.synchronize()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "tutorial") as! UINavigationController
            self.window?.rootViewController = viewController
            self.window?.makeKeyAndVisible()
        }
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
        }
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).tintColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        
        return true
    }

    @objc func iCloudKeysChanged(_ sender: NSNotification) {
        
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

