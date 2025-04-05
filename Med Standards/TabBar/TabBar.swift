//
//  TabBar.swift
//  Med Standards
//
//  Created by Oleksandr on 11.02.2025.
//  Copyright © Doc Apps LLC. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    // MARK: - Private methods
    
    private func setupTabBar() {
        let settingsVC = SettingsVC()
        let navVC = UINavigationController(rootViewController: settingsVC)
        navVC.tabBarItem = UITabBarItem(title: "Settings",
                                        image: UIImage(systemName: "gearshape"),
                                        selectedImage: UIImage(systemName: "gearshape.fill")
        )
        var curentVCs = viewControllers ?? []
        curentVCs.append(navVC)
        viewControllers = curentVCs
    }
}
