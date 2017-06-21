//
//  AppDelegate.swift
//  PalaceEliteUniversity
//
//  Created by Simran on 05/06/17.
//  Copyright © 2017 Simran. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //Setting up Navigation Bar
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        
        //Get first VC
        if StaticHelper.isObjectNotNil(object: UserDefaults.standard.integer(forKey: "launchCount") as AnyObject!){
            
            let count = UserDefaults.standard.integer(forKey: "launchCount")
            UserDefaults.standard.set(count+1, forKey: "launchCount")
            UserDefaults.standard.synchronize()
        }
        else {
            UserDefaults.standard.set(1, forKey: "launchCount")
            UserDefaults.standard.synchronize()
        }
        
        
        let currentCount = UserDefaults.standard.integer(forKey: "launchCount")
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let navController: UINavigationController = storyBoard.instantiateViewController(withIdentifier: "LoginNav") as! UINavigationController
        
        if currentCount == 1 {
            
            let vc: WelcomeViewController = storyBoard.instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeViewController
            
            navController.viewControllers = [vc]
            
            // navController = UINavigationController(rootViewController: vc)
            
            let window: UIWindow = StaticHelper.sharedInstance.mainWindow()
            window.rootViewController = navController
            window.makeKeyAndVisible()
            
            
        }
        else{
            
            if StaticHelper.isObjectNotNil(object: UserDefaults.standard.object(forKey: "userId") as AnyObject!){
                
                let navController2 : UINavigationController = storyBoard.instantiateViewController(withIdentifier: "HomeNavController") as! UINavigationController
                
                let vc: CoursesViewController = storyBoard.instantiateViewController(withIdentifier: "CoursesVC") as! CoursesViewController
                
                navController2.viewControllers = [vc]
                
                //navController2 = UINavigationController(rootViewController: vc)
                
                let window: UIWindow = StaticHelper.sharedInstance.mainWindow()
                window.rootViewController = navController2
                window.makeKeyAndVisible()
            }
                
            else{
                
                let vc: LoginViewController = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
                
                navController.viewControllers = [vc]
                //navController = UINavigationController(rootViewController: vc)
                
                
                let window: UIWindow = StaticHelper.sharedInstance.mainWindow()
                window.rootViewController = navController
                window.makeKeyAndVisible()
                
            }
        }
        
        
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

