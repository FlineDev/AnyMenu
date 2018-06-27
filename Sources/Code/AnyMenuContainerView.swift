//
//  AnyMenuContainerView.swift
//  AnyMenu
//
//  Created by Murat Yilmaz on 27.06.18.
//  Copyright © 2018 Flinesoft. All rights reserved.
//

import UIKit

internal class AnyMenuContainerView: UIView {
    internal weak var animator: AnyMenuViewAnimator?

    override func layoutSubviews() {
        if animator?.isAnimating == true {
            UIView.performWithoutAnimation {
                super.layoutSubviews()
            }
        } else {
            super.layoutSubviews()
        }
    }
}
