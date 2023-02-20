//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Олег Мостовой on 12.02.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let profileHeaderView = ProfileHeaderView()
    
    // добавляем элементы на контроллер
    func setupProfileViewController() {
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileHeaderView)

        NSLayoutConstraint.activate([
            profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileHeaderView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),
            
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Мой профиль"
        
        profileHeaderView.statusButtonChanger().addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
        setupProfileViewController()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profileHeaderView.frame = view.frame
        view.addSubview(profileHeaderView)
        view.backgroundColor = .white
    }
        @objc private func statusButtonPressed() {
            profileHeaderView.statusLabelChanger().text = profileHeaderView.statusTextFieldChanger().text
        }
}
