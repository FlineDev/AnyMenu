//
//  MenuIconConfig.swift
//  AnyMenu
//
//  Created by Cihat Gündüz on 06.09.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import UIKit

/// The Menu icon config.
public struct MenuIconConfig {
    // MARK: - Sub Types
    /// The Menu icon configs line configuration.
    public struct LineConfig {
        let count: Int
        let height: CGFloat
        let verticalGap: CGFloat
        let cornerRadius: CGFloat

        /// Initializes a line config.
        ///
        /// - Paramters:
        ///   - count: The number of lines to be rendered.
        ///   - height: The height of a single lines stroke.
        ///   - verticalGap: The vertical gap between the lines.
        ///   - cornerRadius: The corner radius of the lines.
        public init(count: Int = 3, height: CGFloat = 2.0, verticalGap: CGFloat = 5.5, cornerRadius: CGFloat = 0.0) {
            self.count = count
            self.height = height
            self.verticalGap = verticalGap
            self.cornerRadius = cornerRadius
        }
    }

    // MARK: - Stored Instance Properties
    let width: CGFloat
    let lineConfig: LineConfig

    // MARK: - Initializers
    /// Initializes a Menu icon config.
    ///
    /// - Paramters:
    ///   - width: The width of the resuliting icon image.
    ///   - color: The color of the Menu button.
    ///   - lineConfig: The configuration for the lines.
    public init(width: CGFloat = 25.0, lineConfig: LineConfig = LineConfig()) {
        self.width = width
        self.lineConfig = lineConfig
    }
}
