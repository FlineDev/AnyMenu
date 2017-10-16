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
    internal var shadowView: UIView!

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

    /// The opacity of the menu's shadow. Default `0.3`
    public var menuShadowOpacity: CGFloat = 0.3 {
        didSet {
            if isViewLoaded {
                shadowView.layer.shadowOpacity = Float(menuShadowOpacity)
            }
        }
    }

    /// The blur radius (in points) used to render the menu's shadow. Default `8`
    public var menuShadowRadius: CGFloat = 8 {
        didSet {
            if isViewLoaded {
                shadowView.layer.shadowRadius = menuShadowRadius
            }
        }
    }

    /// The offset (in points) of the menu's shadow. Default `CGSize.zero`
    public var menuShadowOffset: CGSize = .zero {
        didSet {
            if isViewLoaded {
                shadowView.layer.shadowOffset = menuShadowOffset
            }
        }
    }

    /// The color of the menu's shadow. Default `UIColor.black`
    public var menuShadowColor: UIColor? = .black {
        didSet {
            if isViewLoaded {
                shadowView.layer.shadowColor = menuShadowColor?.cgColor
            }
        }
    }

    /// Returns a childViewController for the status bar style.
    public override var childViewControllerForStatusBarStyle: UIViewController? {
        return menuState == .closed ? contentViewController : menuViewController
    }

    /// Returns a childViewController for status bar visibility.
    public override var childViewControllerForStatusBarHidden: UIViewController? {
        return menuState == .closed ? contentViewController : menuViewController
    }

    internal let menuOverlaysContent: Bool

    private var animator: AnyMenuViewAnimator!

    /// The current menu state.
    public internal(set) var menuState: MenuState = .closed {
        didSet {
            setNeedsStatusBarAppearanceUpdate()

            // Adjust user interaction enabled status
            configureContentUserInteraction()
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

        if shadowView == nil {
            shadowView = UIView(frame: view.bounds)
            shadowView.backgroundColor = .clear
            shadowView.clipsToBounds = false
            shadowView.isOpaque = false
            shadowView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            shadowView.translatesAutoresizingMaskIntoConstraints = true

            shadowView.layer.shadowOpacity = Float(menuShadowOpacity)
            shadowView.layer.shadowRadius = menuShadowRadius
            shadowView.layer.shadowOffset = menuShadowOffset
            shadowView.layer.shadowColor = menuShadowColor?.cgColor
            shadowView.layer.shadowPath = CGPath(rect: view.bounds, transform: nil)
            shadowView.layer.masksToBounds = false

            view.addSubview(shadowView)
        }

        view.bringSubview(toFront: menuOverlaysContent ? contentContainerView : menuContainerView)
        view.bringSubview(toFront: shadowView)
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
        // Add new content view controller
        addChildViewController(contentViewController)

        // First add view to self's view which isn't transformed. Thereby, the navigation bar is layouted properly.
        // After this has been done (which isn't visible due to isHidden, real layout can be done.
        contentViewController.view.isHidden = true
        view.addSubview(contentViewController.view)

        // Do real layout
        contentViewController.view.frame = contentContainerView.bounds
        contentViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentViewController.view.translatesAutoresizingMaskIntoConstraints = true
        contentViewController.view.removeFromSuperview()
        contentContainerView.addSubview(contentViewController.view)
        contentViewController.view.isHidden = false
        menuViewController.didMove(toParentViewController: self)

        // Remove old menu view controller if any
        if let oldContentViewController = oldContentViewController {
            oldContentViewController.willMove(toParentViewController: nil)
            oldContentViewController.view.removeFromSuperview()
            oldContentViewController.removeFromParentViewController()
        }

        // Adjust user interaction enabled status
        configureContentUserInteraction()
    }

    private func configureMenuViewFrame() {
        let openMenuContentFrame = view.bounds.applying(animator.finalContentViewTransform)
        menuViewController.view.frame.size.width = menuContainerView.frame.size.width - (menuContainerView.frame.size.width - openMenuContentFrame.origin.x)
        // TODO: make sure the menu size calculation also works for top, bottom and right sided menu
    }

    private func configureContentUserInteraction() {
        // Disable user interaction according to menu state. Disable for subviews since otherwise tap gesture recognizer is also disabled.
        contentContainerView.subviews.forEach { $0.isUserInteractionEnabled = menuState == .closed }
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
        animator.startAnimation(for: .open) { [unowned self] _ in
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }

    /// Closes the menu.
    public func closeMenu() {
        menuState = .closed
        animator.startAnimation(for: .closed) { [unowned self] _ in
            self.setNeedsStatusBarAppearanceUpdate()
        }
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
