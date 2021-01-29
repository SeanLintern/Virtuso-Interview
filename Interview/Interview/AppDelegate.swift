//
//  AppDelegate.swift
//  Interview
//
//  Created by Sean Lintern on 28/01/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigation = UINavigationController()

        window = UIWindow()
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()

        let appCoordinator = AppCoordinator(context: navigation)
        self.coordinator = appCoordinator
        appCoordinator.start()
        
        return true
    }
}

