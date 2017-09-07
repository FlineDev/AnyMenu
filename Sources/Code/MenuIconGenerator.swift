//
//  MenuIconGenerator.swift
//  AnyMenu
//
//  Created by Cihat Gündüz on 06.09.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import UIKit

class MenuIconGenerator {
    // MARK: - Type Methods
    static func menuIconImage(for menuIconType: MenuIconType) -> UIImage {
        switch menuIconType {
        case .default:
            return generateMenuIcon(config: MenuIconConfig())

        case .roundedLines:
            let menuIconConfig = MenuIconConfig(lineConfig: MenuIconConfig.LineConfig(height: 2.0, cornerRadius: 1.0))
            return generateMenuIcon(config: menuIconConfig)

        case .customConfig(let menuIconConfig):
            return generateMenuIcon(config: menuIconConfig)

        case .customImage(let menuIconImage):
            return menuIconImage
        }
    }

    static func generateMenuIcon(config: MenuIconConfig) -> UIImage {
        // create iconView with given configuration
        let height = CGFloat(config.lineConfig.count) * (config.lineConfig.height + config.lineConfig.verticalGap) - config.lineConfig.verticalGap
        let iconShapeLayer = CAShapeLayer()
        iconShapeLayer.frame = CGRect(x: 0, y: 0, width: config.width, height: height)
        iconShapeLayer.backgroundColor = UIColor.clear.cgColor

        for lineIndex in 0..<config.lineConfig.count {
            let yOffset = CGFloat(lineIndex) * (config.lineConfig.height + config.lineConfig.verticalGap)
            let lineShapeLayer = CAShapeLayer()
            lineShapeLayer.frame = CGRect(x: 0, y: yOffset, width: config.width, height: config.lineConfig.height)
            lineShapeLayer.backgroundColor = UIColor.black.cgColor
            lineShapeLayer.cornerRadius = config.lineConfig.cornerRadius
            iconShapeLayer.addSublayer(lineShapeLayer)
        }

        // take screenshot of iconView and return it
        let imageRenderer = UIGraphicsImageRenderer(size: iconShapeLayer.bounds.size)
        return imageRenderer.image { iconShapeLayer.render(in: $0.cgContext) }
    }
}
