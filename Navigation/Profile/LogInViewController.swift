//
//  LogInViewController.swift
//  Navigation
//
//  Created by Олег Мостовой on 01.03.2023.
//

import UIKit

class LogInViewController: UIViewController {
    
    private let notification = NotificationCenter.default

    let scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIScrollView())

    private let contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        return $0
    }(UIView())

    private let logo: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "logo")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())

    private lazy var textField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.indent (size: 10)
        $0.textColor = .black
        $0.tintColor = myColor
        $0.font = .systemFont(ofSize: 16)
        $0.autocapitalizationType = .none
        $0.placeholder = "Email or phone"
        $0.delegate = self
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 0.5
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .systemGray6
        $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return $0
    }(UITextField())

    private lazy var textField2: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.indent (size: 10)
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
        $0.autocapitalizationType = .none
        $0.placeholder = "Password"
        $0.delegate = self
        $0.isSecureTextEntry = true
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 0.5
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .systemGray6
        $0.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        return $0
    }(UITextField())

    var loginButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Log In", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        $0.layer.cornerRadius = 10
        $0.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        $0.layer.masksToBounds = true
        return $0
    }(UIButton())



    func setLoginButtonStates() {
            switch loginButton.state {
            case .normal: loginButton.alpha = 1
            case .selected: loginButton.alpha = 0.8
            case .highlighted: loginButton.alpha = 0.8
            case .disabled: loginButton.alpha = 0.8
            default:
                break
            }
        }
    private func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(logo)
        contentView.addSubview(textField)
        contentView.addSubview(textField2)
        contentView.addSubview(loginButton)

        NSLayoutConstraint.activate([

            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            logo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logo.centerXAnchor.constraint(equalTo:contentView.centerXAnchor),
            logo.heightAnchor.constraint(equalToConstant: 100),
            logo.widthAnchor.constraint(equalToConstant: 100),

            textField.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 120),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 50),

            textField2.topAnchor.constraint(equalTo: textField.bottomAnchor),
            textField2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textField2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            textField2.heightAnchor.constraint(equalToConstant: 50),

            loginButton.topAnchor.constraint(equalTo: textField2.bottomAnchor, constant: 16),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)

        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        hideNavigationBar()
        layout()
        setLoginButtonStates()
        setupLoginButton()
    }
    private func setupLoginButton() {
        loginButton.addTarget(self, action: #selector(tapLoginAction), for: .touchUpInside)
    }
    @objc private func tapLoginAction() {
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notification.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        notification.removeObserver(UIResponder.keyboardWillShowNotification)
        notification.removeObserver(UIResponder.keyboardWillHideNotification)
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keybordSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keybordSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keybordSize.height, right: 0)
        }
    }

    @objc private func keyboardWillHide() {
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }

}



