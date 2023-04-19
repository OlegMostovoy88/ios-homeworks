import UIKit

class ProfileHeaderView: UIView {
    
    // MARK: Аватарка пользователя
    let avatarImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = #imageLiteral(resourceName: "Аватарка2")
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 50.0
        $0.layer.borderWidth = 3.0
        $0.layer.borderColor = UIColor.white.cgColor
        $0.layer.shadowOpacity = 0.7
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.masksToBounds = true
        return $0
    }(UIImageView())
    
    // MARK: Имя пользователя
    private let fullNameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Тот Cамый Найдёнов"
        $0.textColor = #colorLiteral(red: 0.2142065763, green: 0.06068024039, blue: 0.5598060489, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return $0
    }(UILabel())
    
    // MARK: Статус пользователя
    lazy var statusLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Ожидание чего-то..."
        $0.textColor = .darkGray
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return $0
    }(UILabel())
    
    // MARK: Кнопка установки статуса пользователя
    private lazy var setStatusButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Показать статус", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemBlue
        $0.layer.shadowOffset = CGSize(width: 4, height: 4)
        $0.layer.cornerRadius = 16
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.7
        $0.addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    // MARK: Поле для ввода статуса пользователя
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
    
    // MARK: Полупрозначная view
    private let transLucentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.frame = UIScreen.main.bounds
        $0.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        $0.alpha = 0
        return $0
    }(UIView())
    
    // MARK: Крестик
    private lazy var closeProfileImageButton: UIButton = {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.alpha = 0
        $0.tintColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private var topConstraintImage = NSLayoutConstraint()
    private var leadingConstraintImage = NSLayoutConstraint()
    private var widthConstraintImage = NSLayoutConstraint()
    private var heightConstraintImage = NSLayoutConstraint()
    
    
    // MARK: Нажатие на аватарку (разворачивание)
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(tapGesture)
    }
    @objc private func tapAction() {
        addSubview(transLucentView)
        addSubview(closeProfileImageButton)
        bringSubviewToFront(avatarImageView)
        
        NSLayoutConstraint.activate([
            closeProfileImageButton.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            closeProfileImageButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            closeProfileImageButton.widthAnchor.constraint(equalToConstant: 30),
            closeProfileImageButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0) {
            self.transLucentView.alpha = 0.7
            self.avatarImageView.layer.cornerRadius = 0
            self.avatarImageView.layer.borderWidth = 7
            self.topConstraintImage.constant = 150
            self.leadingConstraintImage.constant = 0
            self.widthConstraintImage.constant = UIScreen.main.bounds.width
            self.heightConstraintImage.constant = UIScreen.main.bounds.width
            self.layoutIfNeeded()
        }
        UIView.animateKeyframes(withDuration: 0.3, delay: 0.5) {
            self.closeProfileImageButton.alpha = 1
        }
    }
    
    
    // MARK: Нажатие на крестик (сворачивание)
    @objc private func cancelAction() {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [.calculationModeCubicPaced]) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2) {
                self.closeProfileImageButton.alpha = 0
            }
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.8) {
                self.avatarImageView.layer.cornerRadius = 50
                self.avatarImageView.layer.borderWidth = 3
                self.topConstraintImage.constant = 16
                self.leadingConstraintImage.constant = 16
                self.widthConstraintImage.constant = 100
                self.heightConstraintImage.constant = 100
                self.transLucentView.alpha = 0
                self.layoutIfNeeded()
            }
        }
    }
    
    
    // MARK:  Анимация поддергивание
    private func shakeAnimationForStatusTextField() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: statusTextField.center.x - 7, y: statusTextField.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: statusTextField.center.x + 7, y: statusTextField.center.y))
        
        statusTextField.layer.add(animation, forKey: "position")
    }
    
    @objc private func statusButtonPressed() {
        if statusTextField.text!.isEmpty {
            statusTextField.backgroundColor = #colorLiteral(red: 0.9919111133, green: 0.9757937789, blue: 0.6754880548, alpha: 1)
            shakeAnimationForStatusTextField()
        } else {
            statusTextField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            statusLabel.text = statusTextField.text
            statusTextField.text = ""
            print(statusLabel.text!)
            print(statusLabel.intrinsicContentSize)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupProfileHeaderView()
        setupConstraints()
        setupTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupProfileHeaderView() {
        [avatarImageView, fullNameLabel, statusLabel, statusTextField, setStatusButton].forEach(addSubview)
        backgroundColor = #colorLiteral(red: 0.7742388844, green: 0.7601891756, blue: 1, alpha: 1)
        layer.cornerRadius = 10
        
    }
    
    private func setupConstraints() {
        topConstraintImage = avatarImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Metric.inset)
        leadingConstraintImage = avatarImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Metric.inset)
        widthConstraintImage = avatarImageView.widthAnchor.constraint(equalToConstant: Metric.widthAvatar)
        heightConstraintImage = avatarImageView.heightAnchor.constraint(equalToConstant: Metric.heightAvatar)
        
        NSLayoutConstraint.activate([
            topConstraintImage,
            leadingConstraintImage,
            widthConstraintImage,
            heightConstraintImage,
            
            fullNameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Metric.topAnchorNameLabel),
            fullNameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Metric.leadingAnchorNameLabel),
            fullNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metric.inset),
            
            
            statusLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: Metric.inset),
            statusLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: fullNameLabel.trailingAnchor),
            
            
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: Metric.topAnchorTextField),
            statusTextField.leadingAnchor.constraint(equalTo: statusLabel.leadingAnchor),
            statusTextField.trailingAnchor.constraint(equalTo: statusLabel.trailingAnchor),
            statusTextField.heightAnchor.constraint(equalToConstant: Metric.heightTextField),
            
            
            setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: Metric.inset),
            setStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metric.inset),
            setStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metric.inset),
            setStatusButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Metric.bottomAnchorStatusButton),
            setStatusButton.heightAnchor.constraint(equalToConstant: Metric.heightStatusButton),
        ])
    }
}
extension ProfileHeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
}
extension ProfileHeaderView {
    enum Metric {
        static let inset: CGFloat = 16
        static let widthAvatar: CGFloat = 100
        static let heightAvatar: CGFloat = 100
        static let heightStatusButton: CGFloat = 50
        static let heightTextField: CGFloat = 40
        static let topAnchorNameLabel: CGFloat = 27
        static let topAnchorTextField: CGFloat = 8
        static let leadingAnchorNameLabel: CGFloat = 130
        static let bottomAnchorStatusButton: CGFloat = 15
    }
}
