import UIKit

class LogInViewController: UIViewController {
    
    private var loginButtonCounter = 0
    private let deffaultPassword = "1234qwer"
    private let deffaultLogin = "qwer@mail.ru"
    var callBackTabBarControllerLogIn: (() -> ())?
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
    
    private lazy var logo: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "logo")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = true
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(NoSoapOrPassword)))
        $0.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(fillLoginData)))
        return $0
    }(UIImageView())
    
    private lazy var textFieldEmail: UITextField = {
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
        $0.clearButtonMode = .whileEditing
        $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return $0
    }(UITextField())
    
    private lazy var textFieldPassword: UITextField = {
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
        $0.clearButtonMode = .whileEditing
        $0.clearsOnBeginEditing = false
        $0.isHidden = false
        $0.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        return $0
    }(UITextField())
    
    private lazy var loginButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Log In", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        $0.layer.cornerRadius = 10
        $0.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        $0.layer.masksToBounds = true
        $0.addTarget(self, action: #selector(tapLoginAction), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var showPasswordButton: UIButton = {
        $0.setImage(UIImage(systemName: "eye"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        return $0
    }(UIButton())
    
    // MARK:  Без мыла и пароля)
    @objc private func NoSoapOrPassword() {
        isLoggedIn = true
        loginButtonCounter += 1
        if loginButtonCounter > 1 {
            navigationController?.pushViewController(ProfileViewController(), animated: false)
            loginButtonCounter = 0
        }
    }
    
    @objc private func fillLoginData() {
        textFieldEmail.text = deffaultLogin
        textFieldPassword.text = deffaultPassword
    }
    
    @objc private func showPassword() {
        textFieldPassword.isSecureTextEntry.toggle()
        if textFieldPassword.isSecureTextEntry == false {
            showPasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        } else {
            showPasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }
    
    // MARK:  Анимация поддергивание
    private func shakeAnimationForEmailOrPhone() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: textFieldEmail.center.x - 7, y: textFieldEmail.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: textFieldEmail.center.x + 7, y: textFieldEmail.center.y))
        textFieldEmail.layer.add(animation, forKey: "position")
        textFieldEmail.attributedPlaceholder = NSAttributedString(string: textFieldEmail.placeholder ?? "",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
    }
    
    private func shakeAnimationForPassword() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: textFieldPassword.center.x - 7, y: textFieldPassword.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: textFieldPassword.center.x + 7, y: textFieldPassword.center.y))
        textFieldPassword.layer.add(animation, forKey: "position")
        textFieldPassword.attributedPlaceholder = NSAttributedString(string: textFieldPassword.placeholder ?? "",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
    }
    
    @objc private func tapLoginAction() {
        
        if textFieldEmail.text!.isEmpty && textFieldPassword.text!.isEmpty {
            logo.image = UIImage(named: "logo2")
            shakeAnimationForEmailOrPhone()
            shakeAnimationForPassword()
        }else{
            if textFieldEmail.text == deffaultLogin && textFieldPassword.text == deffaultPassword {
                self.callBackTabBarControllerLogIn?()
            }
            if textFieldPassword.text!.count != 8 {
                warning()
            }
            if correctPassword(textFieldPassword.text!) == false && textFieldPassword.text != ""  {
                textFieldPassword.text = ""
                textFieldPassword.attributedPlaceholder = NSAttributedString(string: " Не корректно введен пароль",
                                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                warning()
            }
            if correctPassword(textFieldPassword.text!) && textFieldEmail.text == ""  {
                textFieldEmail.text = ""
                textFieldEmail.attributedPlaceholder = NSAttributedString(string: " Не введен логин",
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                warning3()
            }
            if correctEmail(textFieldEmail.text!) == false && textFieldEmail.text != ""  {
                textFieldEmail.text = ""
                textFieldEmail.attributedPlaceholder = NSAttributedString(string: " Не корректно введен логин",
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                warning2()
            }
            else{
                logo.image = UIImage(named: "logo")
                let profileVC = ProfileViewController()
                navigationController?.pushViewController(profileVC, animated: true)
            }
        }
    }
    
    //MARK: - Setting Correct Email
    private func correctEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    //MARK: - Setting Correct Password
    private func correctPassword(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordPredicate.evaluate(with: password)
    }
    
    //MARK: - warnings
    @objc private func warning() {
        
        let alert = UIAlertController(title: "Пароль должен содержать минимум 8 символов, не менее 1 алфавита и 1 цифра!", message: "ЭТО ВАЖНО!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Хорошо, я понял!", style: .destructive) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    @objc private func warning2() {
        
        let alert = UIAlertController(title: "Не верно введён логин ", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Попробовать еще раз", style: .cancel) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    @objc private func warning3() {
        
        let alert = UIAlertController(title: " Не введен логин", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Попробовать еще раз", style: .cancel) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
        setLoginButtonStates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textFieldEmail.text = ""
        textFieldPassword.text = ""
        navigationController?.tabBarController?.tabBar.isHidden = true
        notification.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        notification.removeObserver(UIResponder.keyboardWillShowNotification)
        notification.removeObserver(UIResponder.keyboardWillHideNotification)
        navigationController?.tabBarController?.tabBar.isHidden = false
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
    
    private func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(logo)
        contentView.addSubview(textFieldEmail)
        contentView.addSubview(textFieldPassword)
        contentView.addSubview(loginButton)
        contentView.addSubview(showPasswordButton)
        
        
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
            
            logo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metric.topAnchorLogo),
            logo.centerXAnchor.constraint(equalTo:contentView.centerXAnchor),
            logo.heightAnchor.constraint(equalToConstant: Metric.HeightLogo),
            logo.widthAnchor.constraint(equalToConstant: Metric.WidthLogo),
            
            textFieldEmail.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: Metric.topAnchorTextFieldEmail),
            textFieldEmail.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metric.inset),
            textFieldEmail.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metric.inset),
            textFieldEmail.heightAnchor.constraint(equalToConstant: Metric.heightAnchor),
            
            textFieldPassword.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor),
            textFieldPassword.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metric.inset),
            textFieldPassword.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metric.inset),
            textFieldPassword.heightAnchor.constraint(equalToConstant: Metric.heightAnchor),
            
            showPasswordButton.rightAnchor.constraint(equalTo: textFieldPassword.rightAnchor,constant: -Metric.right),
            showPasswordButton.centerYAnchor.constraint(equalTo: textFieldPassword.centerYAnchor),
            showPasswordButton.heightAnchor.constraint(equalTo: textFieldPassword.heightAnchor),
            
            loginButton.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: Metric.inset),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metric.inset),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Metric.inset),
            loginButton.heightAnchor.constraint(equalToConstant: Metric.heightAnchor),
            loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
    }
}

extension LogInViewController {
    enum Metric {
        static let inset: CGFloat = 16
        static let HeightLogo: CGFloat = 100
        static let WidthLogo: CGFloat = 100
        static let topAnchorLogo: CGFloat = 120
        static let topAnchorTextFieldEmail: CGFloat = 120
        static let heightAnchor: CGFloat = 50
        static let right: CGFloat = 25
    }
}
