//
//  AppDelegate.swift
//  AdaptivePhotos
//
//  Created by Haizhen Lee on 15/8/21.
//  Copyright (c) 2015年 banxi1988. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let url = NSBundle.mainBundle().URLForResource("User", withExtension: "plist")
        let userDict = NSDictionary(contentsOfURL: url!)
        let user = AAPLUser(dict: userDict!)
        // Override point for customization after application launch.
        let splitViewController = UISplitViewController()
        splitViewController.delegate = self
        let master = AAPLListTableViewController()
        master.user = user
        let masterNav = UINavigationController(rootViewController: master)
        
        let detail = AAPLEmptyViewController()
        
        splitViewController.viewControllers = [masterNav,detail]
        splitViewController.preferredDisplayMode = .AllVisible
        
        window?.rootViewController = splitViewController
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: - Split view
    
    

    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController:UIViewController!, ontoPrimaryViewController primaryViewController:UIViewController!) -> Bool {
        let photo = secondaryViewController.aapl_containedPhoto
        if photo == nil{
            // If our secondary controller doesn't show a photo, do the collage ourself by doing nothing
            return true
        }else{
            // Before collapsing, remove any view controllers on our stack that  don't match the photo we are
            // about to merge on.
            if let navVC = primaryViewController as? UINavigationController{
                let controllers = navVC.viewControllers as! [UIViewController]
                var newControllers = [UIViewController]()
                for controller in controllers{
                    if controller.aapl_containsPhoto(photo!){
                        newControllers.append(controller)
                    }
                }
                navVC.setViewControllers(newControllers, animated: false)
            }
            return false
        }
        
    }

    func splitViewController(splitViewController: UISplitViewController, separateSecondaryViewControllerFromPrimaryViewController primaryViewController: UIViewController!) -> UIViewController? {
        if let navVC = primaryViewController as? UINavigationController{
            let controllers = navVC.viewControllers as! [UIViewController]
            for controller in controllers{
                if controller.aapl_containedPhoto  != nil{
                    return nil
                }
            }
        }
        
        return AAPLEmptyViewController()
    }

}

