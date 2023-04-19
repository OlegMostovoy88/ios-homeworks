import UIKit

final class FeedViewController: UIViewController {
    
    private let stackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = #colorLiteral(red: 0.1626194715, green: 0.04926132411, blue: 0.4024096727, alpha: 1)
        $0.axis = .vertical
        $0.layer.cornerRadius = 16
        $0.distribution = .equalCentering
        $0.spacing = 10
        return $0
    }(UIStackView())
    
    private lazy var nextPageButton: UIButton = {
        $0.layer.cornerRadius = 16
        $0.setTitle("Показать пост", for: .normal)
        $0.setTitleColor(.systemYellow, for: .highlighted)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        $0.backgroundColor = #colorLiteral(red: 0.1626194715, green: 0.04926132411, blue: 0.4024096727, alpha: 1)
        $0.layer.shadowColor = UIColor.systemYellow.cgColor
        $0.layer.shadowRadius = 4
        $0.layer.shadowOpacity = 0.7
        $0.layer.shadowOffset = CGSize(width: 4, height: 4)
        return $0
    }(UIButton(frame: CGRect(x: 0, y: 0, width: 300, height: 50)))
    
    private lazy var nextPageButton2: UIButton = {
        $0.layer.cornerRadius = 16
        $0.setTitle("Показать пост", for: .normal)
        $0.setTitleColor(.systemYellow, for: .highlighted)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        $0.backgroundColor = #colorLiteral(red: 0.1626194715, green: 0.04926132411, blue: 0.4024096727, alpha: 1)
        $0.layer.shadowColor = UIColor.systemYellow.cgColor
        $0.layer.shadowRadius = 4
        $0.layer.shadowOpacity = 0.7
        $0.layer.shadowOffset = CGSize(width: 4, height: 4)
        return $0
    }(UIButton(frame: CGRect(x: 0, y: 0, width: 300, height: 50)))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
        setupButton()
    }
    
    private func layout() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(nextPageButton)
        stackView.addArrangedSubview(nextPageButton2)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor)
        ])
        
        stackView.setCustomSpacing(40, after: nextPageButton)
        stackView.setCustomSpacing(40, after: nextPageButton2)
    }
    
    private func setupButton() {
        nextPageButton.addTarget(self, action: #selector(tapActionTwo), for: .touchUpInside)
        nextPageButton2.addTarget(self, action: #selector(tapActionTwo), for: .touchUpInside)
    }
    
    @objc private func tapActionTwo() {
        let postVC = PostViewController()
        postVC.title = "PostViewController"
        navigationController?.pushViewController(postVC, animated: true)
    }
    
    @objc private func barItemAction() {
        let postVC = PostViewController()
        postVC.title = "Post VC"
        postVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(postVC, animated: true)
    }
    
    @objc private func buttonAction() {
        let postViewController = PostViewController()
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
}
