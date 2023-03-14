
import UIKit

final class FeedViewController: UIViewController {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = #colorLiteral(red: 0.1626194715, green: 0.04926132411, blue: 0.4024096727, alpha: 1)
        stackView.axis = .vertical
        stackView.layer.cornerRadius = 16
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var nextPageButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        button.layer.cornerRadius = 16
        button.setTitle("Показать пост", for: .normal)
        button.setTitleColor(.systemYellow, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.backgroundColor = #colorLiteral(red: 0.1626194715, green: 0.04926132411, blue: 0.4024096727, alpha: 1)
        button.layer.shadowColor = UIColor.systemYellow.cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        print("нажатие \("Показать пост")")
        return button

    }()
    
    private lazy var nextPageButton2: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        button.layer.cornerRadius = 16
        button.setTitle("Показать пост", for: .normal)
        button.setTitleColor(.systemYellow, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.backgroundColor = #colorLiteral(red: 0.1626194715, green: 0.04926132411, blue: 0.4024096727, alpha: 1)
        button.layer.shadowColor = UIColor.systemYellow.cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        print("нажатие \("Показать пост")")
        return button

    }()
    
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

//    var post = PostVC(title: "Мой пост")
    
   
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
//        postViewController.titlePost = post.title
        }
    


}







    
    

    
    
    
    
    
    
    

