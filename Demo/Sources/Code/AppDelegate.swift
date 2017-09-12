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
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let animation = MenuAnimation(
            duration: 0.4,
            menuViewActions: [],
            contentViewActions: [.translate(x: UIScreen.main.bounds.width * 0.85, y: 0)],
            timingParameters: UICubicTimingParameters(animationCurve: .easeOut)
        )
        let menuViewController = MenuViewController()
        let initialContentViewController = ContentViewController(backgroundColor: .darkGray)

        let anyMenuViewController = AnyMenuViewController(
            menuViewController: menuViewController,
            contentViewController: UINavigationController(rootViewController: initialContentViewController),
            menuOverlaysContent: false,
            animation: animation
        )
        anyMenuViewController.present(in: &window)

        return true
    }
}
