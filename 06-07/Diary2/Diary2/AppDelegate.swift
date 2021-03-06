//
//  AppDelegate.swift
//  Diary2
//
//  Created by Julian1 on 02.04.16.
//  Copyright © 2016 juliankob.com. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var notes = Load()
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
        notes.hardCoded()
        
        if let rootNavController = window?.rootViewController as? UINavigationController {
            if let masterController = rootNavController.topViewController as? NotesTableViewController {
                masterController.diaryNotes = notes
            }
        } else {
            debugPrint("Unexpected root view controller structure")
        }
        
        if let tabController = window?.rootViewController as? UITabBarController,
            let viewControllers = tabController.viewControllers {
            for (i, c) in viewControllers.enumerate() {
                if let navController = c as? UINavigationController {
                  //  let tabBarItem: UITabBarItem? = c.tabBarItem
                    
                    switch navController.topViewController {
                    case let notesController as NotesTableViewController:
                        notesController.diaryNotes = notes
                    case let filterController as FilterViewController:
                         filterController.diaryNotes = notes
                    case let eventsController as EventViewController:
                        eventsController.diary = notes

                    default: break
                    }
                }
            }
        }
        
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


}

