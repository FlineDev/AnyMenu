//
//  AnyMenuViewAnimator.swift
//  AnyMenu iOS
//
//  Created by Murat Yilmaz on 06.09.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import UIKit

internal class AnyMenuViewAnimator: NSObject {
    // MARK: - Stored Instance Properties
    internal weak var menuView: UIView? {
        didSet {
            initialMenuViewTransform = menuView?.transform ?? .identity
        }
    }

    internal weak var contentView: UIView? {
        didSet {
            initialContentViewTransform = contentView?.transform ?? .identity
        }
    }

    private var menuViewAnimation: MenuAnimation
    private var contentViewAnimation: MenuAnimation

    private var initialMenuViewTransform: CGAffineTransform = .identity
    private var finalMenuViewTransform: CGAffineTransform

    private var initialContentViewTransform: CGAffineTransform = .identity
    private var finalContentViewTransform: CGAffineTransform

    // MARK: - Initializers
    internal required init(menuViewAnimation: MenuAnimation, contentViewAnimation: MenuAnimation) {
        self.menuViewAnimation = menuViewAnimation
        self.contentViewAnimation = contentViewAnimation
        self.finalMenuViewTransform = AnyMenuViewAnimator.makeAffineTranform(for: menuViewAnimation)
        self.finalContentViewTransform = AnyMenuViewAnimator.makeAffineTranform(for: contentViewAnimation)
        super.init()
    }

    // MARK: - Type Methods
    private static func makeAffineTranform(for animation: MenuAnimation) -> CGAffineTransform {
        let transforms = animation.actions.map { action -> CGAffineTransform in
            switch action {
            case let .translate(x, y):
                return CGAffineTransform(translationX: x, y: y)

            case let .scale(x, y):
                return CGAffineTransform(scaleX: x, y: y)

            case let .rotate(z):
                return CGAffineTransform(rotationAngle: z)
            }
        }

        return transforms.reduce(CGAffineTransform.identity, { $0.concatenating($1) })
    }

    // MARK: - Instance Methods
    func startAnimation(for state: AnyMenuViewController.MenuState) {
        let targetMenuViewTransform = state == .open ? finalMenuViewTransform : initialContentViewTransform
        let targetContentViewTransform = state == .open ? finalContentViewTransform : initialContentViewTransform

        UIView.animate(withDuration: menuViewAnimation.duration, delay: 0, options: .layoutSubviews, animations: {
            self.menuView?.transform = targetMenuViewTransform
        }, completion: nil)

        UIView.animate(withDuration: contentViewAnimation.duration, delay: 0, options: .layoutSubviews, animations: {
            self.contentView?.transform = targetContentViewTransform
        }, completion: nil)
    }
}
