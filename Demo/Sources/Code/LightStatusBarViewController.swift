//
//  LightStatusBarViewController.swift
//  Demo
//
//  Created by Murat Yilmaz on 12.09.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import UIKit

class LightStatusBarViewController: ContentViewController {
    // MARK: - Computed Instance Properties
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }
}
