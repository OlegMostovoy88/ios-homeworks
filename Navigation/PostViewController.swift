
//  ThirdViewController.swift
//  Navigation

//  Created by Олег Мостовой on 09.02.2023.


import UIKit

final class PostViewController: UIViewController {
    var titlePost: String = "Anonymous"
    
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
            self.view.backgroundColor = .placeholderText
            self.navigationItem.title = titlePost
            makeBarItem()
        
        }
    
    
    
    private func makeBarItem() {
        let barButtItem = UIBarButtonItem(title: "Информация", style: .plain, target: self, action: #selector(buttonAction))
        navigationItem.rightBarButtonItem = barButtItem
        barButtItem.title = "Информация"

        
    }
    @objc private func buttonAction() {
            let infoViewController = InfoViewController()
            self.navigationController?.pushViewController(infoViewController, animated: true)
        
        }
}
