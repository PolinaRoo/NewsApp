//
//  TabBarController.swift
//  NewsApp
//
//  Created by Polina Tereshchenko on 14.08.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.tintColor = .black
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        
        viewControllers = [
            setupNavigationController(rootViewController: GeneralViewController(viewModel: GeneralViewModel()),
                                      title: "General",
                                      image: UIImage(systemName: "newspaper") ?? UIImage.add),
            setupNavigationController(rootViewController: SportsViewController(),
                                      title: "Sports",
                                      image: UIImage(systemName: "figure.disc.sports") ?? UIImage.add),
            setupNavigationController(rootViewController: TechnologyViewController(),
                                      title: "Technology",
                                      image: UIImage(systemName: "gyroscope") ?? UIImage.add)
        ]
        
    }
    
    private func setupNavigationController(rootViewController: UIViewController,
                                           title: String,
                                           image: UIImage) -> UINavigationController {
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.prefersLargeTitles = false
        
        return navigationController
    }
    
    // непрозрачный тапбарGene
    private func setupTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        tabBar.scrollEdgeAppearance = appearance
        
        view.tintColor = .black
    }
}
