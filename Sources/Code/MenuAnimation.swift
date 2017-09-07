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

    /// The duration of the transition animation.
    public let duration: TimeInterval

    /// The collection of animations to apply while transitioning.
    public let actions: [Action]

    /// The timing parameters of the animation.
    public let timingParameters: UITimingCurveProvider

    // MARK: - Initializers
    /// Creates a new `MenuAnimation` instannce.
    public init(duration: TimeInterval, actions: [Action], timingParameters: UITimingCurveProvider) {
        self.duration = duration
        self.actions = actions
        self.timingParameters = timingParameters
    }
}

/// Pre configured menu animations
extension MenuAnimation {
    /// Default animation for menu transitions.
    public static let `default` = MenuAnimation(
        duration: 0.3, actions: [.translate(x: 300, y: 0)], timingParameters: UICubicTimingParameters(animationCurve: .easeOut)
    )
//
//    public static let enbw = MenuAnimation(duration: 0.3, actions: [.translate(x: 320, y: 0), .scale(x: 0.9, y: 0.9)], timingParameters: UICubicTimingParameters(animationCurve: .easeOut))
}
