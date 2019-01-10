//
//  AppDelegate.swift
//  NicksBeerGlasses
//
//  Created by Lois Gussenhoven on 13-11-18.
//  Copyright © 2018 Lois Gussenhoven. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        BeerGlassManager.shared.setUpBeerglasses()
        BeerGlassManager.shared.setUpBeerglass()
        BeerGlassManager.shared.setUpFavorites()
        UserDefaults.standard.set(false, forKey: "loggedIn")
        
        UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        
        let viewController = LoadingViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        UINavigationBar.appearance().tintColor = UIColor.white
        return true
    }

}

