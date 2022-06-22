//
//  AppDelegate.swift
//  news-demo
//
//  Created by Johel Zarco on 13/06/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application : UIApplication, didFinishLaunchingWithOptions launchOptions : [UIApplication.LaunchOptionsKey : Any]?) -> Bool{
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        let controller = ViewController()
        // needs to be enbebbed in navigation controller in order to push/pop
        let navController = UINavigationController(rootViewController: controller)
        window?.rootViewController = navController
        return true
    }
}

