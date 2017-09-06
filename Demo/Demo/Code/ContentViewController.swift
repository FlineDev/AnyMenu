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
        navigationItem.leftBarButtonItem = makeMenuBarButtonItem(menuIconType: .default)
        // NOTE: uncomment the following and comment the above to shop menu button
//        view.addSubview(makeButton(menuIconType: .default))
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // TODO: move the following to viewDidLoad
        navigationItem.leftBarButtonItem = makeMenuBarButtonItem(menuIconType: .default)
    }
}
