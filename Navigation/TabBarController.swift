//
//  TabBarController.swift
//  Navigation
//
//  Created by Олег Мостовой on 09.02.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    private let firstVC = FeedViewController()
    private let secondVC = ProfileViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConrollers()
    }
    
    private func setupConrollers() {
        let navigationController = UINavigationController(rootViewController: firstVC)
        firstVC.tabBarItem.title = "Лента пользователя"
        firstVC.tabBarItem.image = UIImage(systemName: "doc.richtext")
        
        
        secondVC.tabBarItem.title = "Профиль"
        secondVC.tabBarItem.image = UIImage(systemName: "person.circle")
        
        viewControllers = [navigationController, secondVC]
    }
}





















