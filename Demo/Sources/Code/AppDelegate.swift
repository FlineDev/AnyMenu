//
//  AppDelegate.swift
//  Demo
//
//  Created by Cihat Gündüz on 05.09.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import UIKit
import AnyMenu

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Stored Instance Properties
    var window: UIWindow?

    // MARK: - App Lifecycle Methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let menuViewController = MenuViewController()
        let initialContentViewController = ContentViewController(backgroundColor: .darkGray)

        let anyMenuViewController = AnyMenuViewController(
            menuViewController: menuViewController,
            contentViewController: UINavigationController(rootViewController: initialContentViewController),
            menuOverlaysContent: false,
            animation: .default
        )
        anyMenuViewController.present(in: &window)

        return true
    }
}
