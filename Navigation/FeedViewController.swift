
import UIKit

final class FeedViewController: UIViewController {
    
    var post = Post(title: "Мой пост")
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1312785149, green: 0.03987477347, blue: 0.3262543678, alpha: 1)
        setupButton()

    }
    
    private func setupButton() {
        view.addSubview(nextPageButton)
        nextPageButton.center = view.center
        nextPageButton.addTarget(self, action: #selector(tapActionTwo), for: .touchUpInside)
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
//        present(thirdVC, animated: true)
        navigationController?.pushViewController(postVC, animated: true)
    }
    @objc private func buttonAction() {
            let postViewController = PostViewController()
            self.navigationController?.pushViewController(postViewController, animated: true)
        postViewController.titlePost = post.title
        }
    
    struct Post {
        var title: String
    }
}
