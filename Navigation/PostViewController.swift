
//  ThirdViewController.swift
//  Navigation

//  Created by Олег Мостовой on 09.02.2023.


import UIKit

final class PostViewController: UIViewController {
    var titlePost: String = "Мой пост"
   
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
            self.view.backgroundColor = #colorLiteral(red: 0.1312785149, green: 0.03987477347, blue: 0.3262543678, alpha: 1)
            self.navigationItem.title = titlePost
            makeBarItem()
        
        
        }
    
    
    
    private func makeBarItem() {
        let barButtItem = UIBarButtonItem(title: "Информация", style: .done, target: self, action: #selector(buttonAction))
        navigationItem.rightBarButtonItem = barButtItem

       
    }
    @objc private func buttonAction() {
            let infoViewController = InfoViewController()
            self.navigationController?.pushViewController(infoViewController, animated: true)
        
        }
}
