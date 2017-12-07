//
//  AppDelegate.swift
//  Personal Packing Assistant
//
//  Created by Kristin Beese on 9/13/17.
//  Copyright © 2017 CS407. All rights reserved.
//

import UIKit
import RealmSwift


let realm = try! Realm()


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    

    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.


        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: HomeViewController())
        
        window?.makeKeyAndVisible()
        
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        // Comment out when modifying the models 
        // try! FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)

        changeColors()
        /*
        
        let a1 = Activity()
        a1.icon = "🏊"
        a1.name = "swimming"
        let a2 = Activity()
        a2.icon = "⛺"
        a2.name = "camping"
        let a3 = Activity()
        a3.icon = "🎣"
        a3.name = "fishing"
        let a4 = Activity()
        a4.icon = "💃"
        a4.name = "dancing"
        
        try! realm.write {
            var sa1 = realm.object(ofType: Activity.self, forPrimaryKey: a1.name)
            if ( sa1 == nil) {
                realm.add(a1)
            }
            
            sa1 = realm.object(ofType: Activity.self, forPrimaryKey: a2.name)
            if ( sa1 == nil) {
                realm.add(a2)
            }
            
            sa1 = realm.object(ofType: Activity.self, forPrimaryKey: a3.name)
            if ( sa1 == nil) {
                realm.add(a3)
            }
            
            sa1 = realm.object(ofType: Activity.self, forPrimaryKey: a4.name)
            if ( sa1 == nil) {
                realm.add(a4)
            }
        }
         */
 
        return true
    }
    
    // changes colors of the menu nav bar
    func changeColors() {
        // Override point for customization after application launch.
        //UINavigationBar.appearance().barTintColor = UIColor(red: 0, green: 0/255, blue: 205/255, alpha: 1)
        //UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        //UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        UIBarButtonItem.appearance().tintColor = UIColor(red: 60/255, green: 155/255, blue: 175/255, alpha: 1.0)
        
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

