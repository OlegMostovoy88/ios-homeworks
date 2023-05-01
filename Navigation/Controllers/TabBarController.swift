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
        UITabBar.appearance().tintColor = #colorLiteral(red: 0.210213542, green: 0.0632795915, blue: 0.5209727883, alpha: 1)
        
        
        viewControllers = [logInViewController, feedNavigationController]
        feedNavigationController.tabBarItem.title = "Лента"
        feedNavigationController.tabBarItem.image = UIImage(systemName: "doc.circle")
        logInViewController.tabBarItem.title = "Профиль"
        logInViewController.tabBarItem.image = UIImage(systemName: "person.circle")
    }
}
