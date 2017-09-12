//
//  MenuViewController.swift
//  Demo
//
//  Created by Cihat Gündüz on 05.09.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {
    // MARK: - Computed Instance Properties
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    // MARK: - Stored Instance Properties
    private var currentIndex: Int = 0

    // MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "basicCell")

        view.backgroundColor = UIColor.white
    }

    // MARK: - UITableViewDataSource Protocol Implementation
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell")!
        cell.backgroundColor = .clear
        cell.accessoryType = currentIndex == indexPath.row ? .checkmark : .none

        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Yellow"
            return cell

        case 1:
            cell.textLabel?.text = "Blue with NavigationBar"
            return cell

        case 2:
            cell.textLabel?.text = "Black with Light StatusBar"
            return cell

        default:
            fatalError()
        }
    }

    // MARK: - UITableVIewDelegate Protocol Implementation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        currentIndex = indexPath.row

        switch indexPath.row {
        case 0:
            anyMenuViewController?.contentViewController = ContentViewController(backgroundColor: .yellow)
            anyMenuViewController?.closeMenu()

        case 1:
            anyMenuViewController?.contentViewController = UINavigationController(rootViewController: ContentViewController(backgroundColor: .blue))
            anyMenuViewController?.closeMenu()

        case 2:
            anyMenuViewController?.contentViewController = LightStatusBarViewController(backgroundColor: .black)
            anyMenuViewController?.closeMenu()
        default:
            fatalError()
        }

        tableView.reloadData()
    }
}
