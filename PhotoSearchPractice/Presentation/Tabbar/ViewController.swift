//
//  ViewController.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/17/25.
//

import UIKit

final class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configTabBar()
        setupTabbarAppearance()
    }
    
    func configTabBar() {
        let firstVC = UINavigationController(rootViewController: TopicViewController())
        firstVC.tabBarItem.image = UIImage(systemName: "chart.xyaxis.line")
        firstVC.tabBarItem.selectedImage = UIImage(systemName: "chart.xyaxis.line")
        
        let thirdVC = UINavigationController(rootViewController: SearchViewController())
        thirdVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        thirdVC.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass")
        
        setViewControllers([firstVC, thirdVC], animated: true)
    }

    func setupTabbarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .secondarySystemBackground
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = .black
        
    }
}

extension ViewController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(item)
    }
}
