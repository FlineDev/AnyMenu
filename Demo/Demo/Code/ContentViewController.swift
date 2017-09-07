//
//  ContentViewController.swift
//  Demo
//
//  Created by Cihat Gündüz on 05.09.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    // MARK: - Stored Instance Properties
    let backgroundColor: UIColor

    // MARK: - Initializers
    init(backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = backgroundColor

        // add menu button
        if navigationController != nil {
            navigationItem.leftBarButtonItem = makeMenuBarButtonItem(menuIconType: .default)
        } else {
            let menuButton = makeButton(menuIconType: .default)
            // set the frame of the menuButton
            view.addSubview(menuButton)
        }
    }
}
