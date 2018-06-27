//
//  UIViewControllerExtension.swift
//  AnyMenu
//
//  Created by Cihat Gündüz on 06.09.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import UIKit

extension UIViewController {
    // MARK: - Computed Instance Properties
    /// Returns the menu container view controller if any exists.
    public var anyMenuViewController: AnyMenuViewController? {
        return AnyMenuViewController.shared
    }

    // MARK: - Instance Methods
    /// Creates a bar button item which opens/closes the menu.
    ///
    /// - Parameters:
    ///   - menuIconType: The menu icon type which configures the icon.
    public func makeMenuBarButtonItem(menuIconType: MenuIconType) -> UIBarButtonItem {
        let menuIconImage = MenuIconGenerator.menuIconImage(for: menuIconType)
        let barButtonItem = UIBarButtonItem(image: menuIconImage, style: .plain, target: self, action: #selector(toggleMenu))
        return barButtonItem
    }

    /// Creates a button which opens/closes the menu.
    ///
    /// - Parameters:
    ///   - menuIconType: The menu icon type which configures the icon.
    public func makeButton(menuIconType: MenuIconType) -> UIButton {
        let menuIconImage = MenuIconGenerator.menuIconImage(for: menuIconType)
        let buttonSize = max(menuIconImage.size.width, menuIconImage.size.height, 44.0)
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 4, y: 20, width: buttonSize, height: buttonSize)
        button.setImage(menuIconImage, for: .normal)
        button.addTarget(self, action: #selector(toggleMenu), for: .primaryActionTriggered)
        return button
    }

    @objc
    func toggleMenu() {
        if let anyMenuViewController = anyMenuViewController {
            switch anyMenuViewController.menuState {
            case .open, .transitionFromOpen:
                anyMenuViewController.closeMenu()

            case .closed, .trasitionFromClosed:
                anyMenuViewController.openMenu()
            }
        }
    }
}
