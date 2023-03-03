//
//  TabBarController.swift
//  Navigation
//
//  Created by Олег Мостовой on 09.02.2023.
//
import UIKit

final class TabBarController: UITabBarController {
    
    private let feedNavigationController = UINavigationController(rootViewController: FeedViewController())
    private let profileNavigationController = UINavigationController(rootViewController: ProfileViewController())
    private let postViewController = UINavigationController(rootViewController: PostViewController())
    private let logInViewController = UINavigationController(rootViewController: LogInViewController())
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConrollers()
    }
    
    private func setupConrollers() {
        self.tabBar.backgroundColor = .white
        
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "LeagueGothic-Regular", size: 16.0)!,NSAttributedString.Key.foregroundColor: UIColor.white]
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().tintColor = #colorLiteral(red: 0.2632796168, green: 0.07878478616, blue: 0.6532559991, alpha: 1)
        
        
        
        viewControllers = [feedNavigationController, logInViewController]
        feedNavigationController.tabBarItem.title = "Лента"
        feedNavigationController.tabBarItem.image = UIImage(systemName: "doc.richtext")
        logInViewController.tabBarItem.title = "Профиль"
        logInViewController.tabBarItem.image = UIImage(systemName: "person.circle.fill")
    }
}



















