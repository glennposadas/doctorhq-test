//
//  AppDelegate.swift
//  DoctorHQ
//
//  Created by Glenn Von C. Posadas on 27/05/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let homeViewController = HomeViewController()
        let navigationController = UINavigationController(rootViewController: homeViewController)
        navigationController.isNavigationBarHidden = true
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

