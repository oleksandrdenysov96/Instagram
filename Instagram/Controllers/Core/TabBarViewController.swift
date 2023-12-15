//
//  TabBarViewController.swift
//  Instagram
//
//  Created by Oleksandr Denysov on 14.12.2023.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVC = HomeViewController()
        let exploreVC = ExploreViewController()
        let cameraVC = CameraViewController()
        let activityVC = NotificationsViewController()
        let profileVC = ProfileViewController()

        let homeNavVC = UINavigationController(rootViewController: homeVC)
        let exploreNavVC = UINavigationController(rootViewController: exploreVC)
        let cameraNavVC = UINavigationController(rootViewController: cameraVC)
        let activityNavVC = UINavigationController(rootViewController: activityVC)
        let profileNavVC = UINavigationController(rootViewController: profileVC)

        homeNavVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        exploreNavVC.tabBarItem = UITabBarItem(title: "Explore", image: UIImage(systemName: "safari"), tag: 2)
        cameraNavVC.tabBarItem = UITabBarItem(title: "Camera", image: UIImage(systemName: "camera"), tag: 3)
        activityNavVC.tabBarItem = UITabBarItem(title: "Notifications", image: UIImage(systemName: "bell"), tag: 4)
        profileNavVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 5)

        self.setViewControllers(
            [homeNavVC, exploreNavVC, cameraNavVC, activityNavVC, profileNavVC],
            animated: false
        )
    }

}
