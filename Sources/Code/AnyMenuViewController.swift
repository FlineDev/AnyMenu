//
//  AnyMenuViewController.swift
//  AnyMenu
//
//  Created by Cihat Gündüz on 05.09.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import UIKit

/// The container view controller coordinating the menu opening/close animations.
public class AnyMenuViewController: UIViewController {
    // MARK: - Sub Types
    /// The menu state.
    public enum MenuState {
        case open
        case closed
    }

    // MARK: - Stored Type Properties
    static weak var shared: AnyMenuViewController?

    // MARK: - Stored Instance Properties
    /// The menu view controller which contains the menu.
    public var menuViewController: UIViewController {
        didSet {
            guard oldValue !== menuViewController else { return }

            configureMenuViewController()
            configureMenuOverlaysContent()
        }
    }

    /// The current content view controller to be shown.
    public var contentViewController: UIViewController {
        didSet {
            guard oldValue !== contentViewController else { return }

            configureContentViewController()
            configureMenuOverlaysContent()
        }
    }

    private let menuOverlaysContent: Bool

    private var animator: AnyMenuViewAnimator

    /// The current menu state.
    public private(set) var menuState: MenuState = .closed

    // MARK: - Initializers
    /// Creates a new menu container view controller.
    ///
    /// - Parameters:
    ///   - menuViewController: The menu view controller which contains the menu.
    ///   - contentViewController: The initial content view controller to be shown.
    public required init(menuViewController: UIViewController, contentViewController: UIViewController,
                         menuOverlaysContent: Bool, menuViewAnimation: MenuAnimation, contentViewAnimation: MenuAnimation) {
        self.menuViewController = menuViewController
        self.contentViewController = contentViewController
        self.menuOverlaysContent = menuOverlaysContent
        self.animator = AnyMenuViewAnimator(menuViewAnimation: menuViewAnimation, contentViewAnimation: contentViewAnimation)
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        AnyMenuViewController.shared = self
        configureMenuViewController()
        configureContentViewController()
        configureMenuOverlaysContent()
    }

    // MARK: - Instance Methods
    private func configureMenuViewController(oldMenuViewController: UIViewController? = nil) {
        // remove old menu view controller if any
        if let oldMenuViewController = oldMenuViewController {
            oldMenuViewController.willMove(toParentViewController: nil)
            oldMenuViewController.view.removeFromSuperview()
            oldMenuViewController.removeFromParentViewController()
        }

        // add new menu view controller
        addChildViewController(menuViewController)
        menuViewController.view.frame = view.bounds
        view.addSubview(menuViewController.view)
        menuViewController.didMove(toParentViewController: self)
        animator.menuView = menuViewController.view
    }

    private func configureContentViewController(oldContentViewController: UIViewController? = nil) {
        // remove old menu view controller if any
        if let oldContentViewController = oldContentViewController {
            oldContentViewController.willMove(toParentViewController: nil)
            oldContentViewController.view.removeFromSuperview()
            oldContentViewController.removeFromParentViewController()
        }

        // add new content view controller
        addChildViewController(contentViewController)
        contentViewController.view.frame = view.bounds
        view.addSubview(contentViewController.view)
        menuViewController.didMove(toParentViewController: self)
        animator.contentView = contentViewController.view
    }

    private func configureMenuOverlaysContent() {
        view.bringSubview(toFront: menuOverlaysContent ? menuViewController.view : contentViewController.view)
    }

    @objc
    private func didPressMenuButton() {
        openMenu()
    }

    @objc
    private func didTriggerCloseMenu() {
        closeMenu()
    }

    /// Opens the menu.
    public func openMenu() {
        menuState = .open
        animator.startAnimation(for: .open)
    }

    /// Closes the menu.
    public func closeMenu() {
        menuState = .closed
        animator.startAnimation(for: .closed)
    }

    /// Present menu view controller in a UIWindow.
    public func present(in window: inout UIWindow?) {
        if window == nil {
            window = UIWindow()
        }

        window!.rootViewController = self
        window!.makeKeyAndVisible()
    }
}
