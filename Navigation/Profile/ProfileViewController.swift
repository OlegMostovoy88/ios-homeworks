//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Олег Мостовой on 12.02.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let profileHeaderView = ProfileHeaderView()
    
    private let newButton: UIButton = {
        var button = UIButton(type: .system)
        button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Новая кнопка", for: .normal)
        button.setTitleColor(.systemYellow, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.backgroundColor = #colorLiteral(red: 0.1626194715, green: 0.04926132411, blue: 0.4024096727, alpha: 1)
        button.layer.cornerRadius = 16
        button.layer.shadowColor = UIColor.systemYellow.cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        return button
    }()

    func setupProfileViewController() {
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),
            
            newButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            newButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Мой профиль"
        view.backgroundColor = .white
        view.addSubview(profileHeaderView)
        view.addSubview(newButton)
        setupProfileViewController()
        
    }
}
