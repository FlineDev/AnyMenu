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
    internal var backgroundContainerView: UIView!
    internal var menuContainerView: UIView!
    internal var contentContainerView: UIView!

    /// The background view controller which is the background of the menu.
    public var backgroundViewController: UIViewController? {
        didSet {
            guard oldValue !== backgroundViewController else { return }

            if isViewLoaded {
                configureBackgroundViewController(oldBackgroundViewController: backgroundViewController)
            }
        }
    }

    /// The menu view controller which contains the menu.
    public var menuViewController: UIViewController {
        didSet {
            guard oldValue !== menuViewController else { return }

            if isViewLoaded {
                configureMenuViewController(oldMenuViewController: oldValue)
            }
        }
    }

    /// The current content view controller to be shown.
    public var contentViewController: UIViewController {
        didSet {
            guard oldValue !== contentViewController else { return }

            if isViewLoaded {
                configureContentViewController(oldContentViewController: oldValue)
            }
        }
    }

    private var forceContentViewForStatusBarStyle: Bool = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }

    /// Returns a childViewController for the status bar style.
    public override var childViewControllerForStatusBarStyle: UIViewController? {
        guard !forceContentViewForStatusBarStyle else { return contentViewController }

        return menuState == .closed ? contentViewController : menuViewController
    }

    /// Returns a childViewController for status bar visibility.
    public override var childViewControllerForStatusBarHidden: UIViewController? {
        guard !forceContentViewForStatusBarStyle else { return contentViewController }

        return menuState == .closed ? contentViewController : menuViewController
    }

    private let menuOverlaysContent: Bool

    private var animator: AnyMenuViewAnimator!

    /// The current menu state.
    public internal(set) var menuState: MenuState = .closed {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
            contentContainerView.subviews.forEach { $0.isUserInteractionEnabled = menuState == .closed }
        }
    }

    // MARK: - Initializers
    /// Creates a new menu container view controller.
    ///
    /// - Parameters:
    ///   - menuViewController: The menu view controller which contains the menu.
    ///   - contentViewController: The initial content view controller to be shown.
    public required init(menuViewController: UIViewController, contentViewController: UIViewController,
                         menuOverlaysContent: Bool, animation: MenuAnimation = .default) {
        self.menuViewController = menuViewController
        self.contentViewController = contentViewController
        self.menuOverlaysContent = menuOverlaysContent
        super.init(nibName: nil, bundle: nil)
        self.animator = AnyMenuViewAnimator(animation: animation)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        configureViews()

        AnyMenuViewController.shared = self

        configureMenuViewController()
        configureContentViewController()

        animator.configure(forViewController: self)
        configureMenuViewFrame()
    }

    // MARK: - Instance Methods
    private func configureViews() {
        if backgroundContainerView == nil {
            backgroundContainerView = UIView(frame: view.bounds)
            backgroundContainerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            backgroundContainerView.translatesAutoresizingMaskIntoConstraints = true
            backgroundContainerView.backgroundColor = .clear

            view.addSubview(backgroundContainerView)
        }

        if menuContainerView == nil {
            menuContainerView = UIView(frame: view.bounds)
            menuContainerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            menuContainerView.translatesAutoresizingMaskIntoConstraints = true
            menuContainerView.backgroundColor = .clear
            menuContainerView.clipsToBounds = true

            view.addSubview(menuContainerView)
        }

        if contentContainerView == nil {
            contentContainerView = UIView(frame: view.bounds)
            contentContainerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            contentContainerView.translatesAutoresizingMaskIntoConstraints = true
            contentContainerView.backgroundColor = .clear
            contentContainerView.clipsToBounds = true

            view.addSubview(contentContainerView)
        }

        view.bringSubview(toFront: menuOverlaysContent ? menuContainerView : contentContainerView)
    }

    private func configureBackgroundViewController(oldBackgroundViewController: UIViewController?) {
        // remove old background view controller if any
        if let oldBackgroundViewController = oldBackgroundViewController {
            oldBackgroundViewController.willMove(toParentViewController: nil)
            oldBackgroundViewController.view.removeFromSuperview()
            oldBackgroundViewController.removeFromParentViewController()
        }

        // add new background view controller
        if let backgroundViewController = backgroundViewController {
            addChildViewController(backgroundViewController)
            backgroundViewController.view.frame = menuContainerView.bounds
            backgroundViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            backgroundViewController.view.translatesAutoresizingMaskIntoConstraints = true
            backgroundContainerView.addSubview(backgroundViewController.view)
            backgroundViewController.didMove(toParentViewController: self)
        }
    }

    private func configureMenuViewController(oldMenuViewController: UIViewController? = nil) {
        // remove old menu view controller if any
        if let oldMenuViewController = oldMenuViewController {
            oldMenuViewController.willMove(toParentViewController: nil)
            oldMenuViewController.view.removeFromSuperview()
            oldMenuViewController.removeFromParentViewController()
        }

        // add new menu view controller
        addChildViewController(menuViewController)
        menuViewController.view.frame = menuContainerView.bounds
        menuViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        menuViewController.view.translatesAutoresizingMaskIntoConstraints = true
        menuContainerView.addSubview(menuViewController.view)
        menuViewController.didMove(toParentViewController: self)

        backgroundContainerView.backgroundColor = menuViewController.view.backgroundColor
    }

    private func configureContentViewController(oldContentViewController: UIViewController? = nil) {
        // remove old menu view controller if any
        if let oldContentViewController = oldContentViewController {
            oldContentViewController.willMove(toParentViewController: nil)
            oldContentViewController.view.removeFromSuperview()
            oldContentViewController.removeFromParentViewController()
        }

        // Fixes wrong content view controller status bar layout inset
        forceContentViewForStatusBarStyle = true

        // add new content view controller
        addChildViewController(contentViewController)
        contentViewController.view.frame = contentContainerView.bounds
        contentViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentViewController.view.translatesAutoresizingMaskIntoConstraints = true
        contentContainerView.addSubview(contentViewController.view)
        menuViewController.didMove(toParentViewController: self)

        forceContentViewForStatusBarStyle = false
    }

    private func configureMenuViewFrame() {
        let openMenuContentFrame = view.bounds.applying(animator.finalContentViewTransform)
        menuViewController.view.frame.size.width = menuContainerView.frame.size.width - (menuContainerView.frame.size.width - openMenuContentFrame.origin.x)
        // TODO: make sure the menu size calculation also works for top, bottom and right sided menu
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
