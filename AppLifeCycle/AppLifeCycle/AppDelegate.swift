//
//  AppDelegate.swift
//  AppLIfeCycle
//
//  Created by MAC on 22/03/2020.
//  Copyright © 2020 Gera Volobuev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print("The app finished launching.")
        return true
    }

    // MARK: UISceneSession Lifecycle
    


    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func applicationDidFinishLaunching(_ application: UIApplication) {
        print("Did finish launching")
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // This function is called then the app is about to leave the foreground
        print("The app will leave the forground soon")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // this methods called immediately after the previous one
        print("the app has enteren the background")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background. //
        print("The app has entered the foreground")
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        //Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print("The app did become active")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. For apps that are allowed to execute code in the background—such as apps that provide GPS directions, play music, or handle audio calls—you'll want to call the applicationDidEnterBackground function. For apps that don't normally run in the background, you'll use the applicationWillTerminate function.
        print("The app is about to terminate soon")
    }
    
}

