//
//  MenuAnimation.swift
//  AnyMenu iOS
//
//  Created by Murat Yilmaz on 06.09.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import UIKit

/// A animation structure to describe menu animations.
public struct MenuAnimation {
    // MARK: - Sub Types
    /// Animation actions that can be applied to a view.
    public enum Action {
        case translate(x: CGFloat, y: CGFloat)
        case scale(x: CGFloat, y: CGFloat)
        case rotate(z: CGFloat)
    }

    /// The duration of the animation
    public let duration: TimeInterval

    /// The collection of animations to apply on menu view while transitioning.
    public let menuViewActions: [Action]

    /// The collection of animations to apply on content view while transitioning.
    public let contentViewActions: [Action]

    /// The timing parameters of the animation.
    public let timingParameters: UITimingCurveProvider

    // MARK: - Initializers
    /// Creates a new `MenuAnimation` instannce.
    public init(duration: TimeInterval, menuViewActions: [Action], contentViewActions: [Action], timingParameters: UITimingCurveProvider) {
        self.duration = duration
        self.menuViewActions = menuViewActions
        self.contentViewActions = contentViewActions
        self.timingParameters = timingParameters
    }
}

/// Pre configured menu animations
extension MenuAnimation {
    /// Empy animation
    public static let none = MenuAnimation(
        duration: 0, menuViewActions: [], contentViewActions: [], timingParameters: UICubicTimingParameters(animationCurve: .linear)
    )

    /// Default animation
    public static let `default` = MenuAnimation(
        duration: 0.3, menuViewActions: [], contentViewActions: [.translate(x: 300, y: 0)], timingParameters: UICubicTimingParameters(animationCurve: .easeOut)
    )
//
//    public static let enbw = MenuAnimation(duration: 0.3, actions: [.translate(x: 320, y: 0), .scale(x: 0.9, y: 0.9)], timingParameters: UICubicTimingParameters(animationCurve: .easeOut))
}
