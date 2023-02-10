//
//  InfoViewController.swift
//  Navigation
//
//  Created by Олег Мостовой on 10.02.2023.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .placeholderText
        setupButton()
        
    }
    private lazy var backButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        button.layer.cornerRadius = 16
        button.setTitle("Покинуть?", for: .normal)
        button.setTitleColor(.systemYellow, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.backgroundColor = .systemIndigo
        return button
    }()
    
    private func setupButton() {
        view.addSubview(backButton)
        backButton.center = view.center
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
    }
    
    
    @objc private func backAction() {
        
        let alert = UIAlertController(title: "Вы точно хотите выйти?", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Выйти", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive)
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true)
        
    }
}
