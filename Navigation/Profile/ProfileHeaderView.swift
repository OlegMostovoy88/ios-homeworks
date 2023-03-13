//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Олег Мостовой on 12.02.2023.
//
import UIKit

class ProfileHeaderView: UIView {
    
    // аватарка пользователя
    private let avatarImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = #imageLiteral(resourceName: "Аватарка2")
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 50.0
        $0.layer.borderWidth = 3.0
        $0.layer.borderColor = UIColor.white.cgColor
        $0.layer.masksToBounds = true
        return $0
    }(UIImageView())
    
    // имя пользователя
    private let fullNameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Тот самый Найдёнов"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return $0
    }(UILabel())
    
    // статус пользователя
    lazy var statusLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Ожидание чего-то..."
        $0.textColor = .darkGray
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return $0
    }(UILabel())
    
    // кнопка установки статуса пользователя
    private let setStatusButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Показать статус", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemBlue
        $0.layer.shadowOffset = CGSize(width: 4, height: 4)
        $0.layer.cornerRadius = 16
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.7
        $0.addTarget(ProfileHeaderView.self, action: #selector(statusButtonPressed), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    // поле для ввода статуса пользователя
    let statusTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "Введите статус"
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
        $0.font = .systemFont(ofSize: 15, weight: .regular)
        $0.textColor = .black
        $0.indent(size: 10)
        return $0
    }(UITextField())
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupProfileHeaderView()
        propertiesHeader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func statusButtonPressed() {
        statusLabel.text = statusTextField.text
        print(statusLabel.text!)
        print(statusLabel.intrinsicContentSize)
    }
    // свойства HeaderView
    func propertiesHeader() {
        backgroundColor = .lightGray
        layer.cornerRadius = 16
        layer.borderWidth = 2
        layer.borderColor = UIColor.purple.cgColor
    }
    //добавление на экран, установка констрейнтов для всех элементов
    func setupProfileHeaderView() {
        [avatarImageView, fullNameLabel, statusLabel, statusTextField, setStatusButton].forEach(addSubview)
        NSLayoutConstraint.activate([
            
            avatarImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            
            fullNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27),
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            fullNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            fullNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            statusLabel.topAnchor.constraint(equalTo: fullNameLabel.topAnchor, constant: 30),
            statusLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            statusLabel.heightAnchor.constraint(equalToConstant: 20),
            
            statusTextField.topAnchor.constraint(equalTo: statusLabel.topAnchor, constant: 20),
            statusTextField.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            statusTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            
            
            setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            setStatusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            setStatusButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}


