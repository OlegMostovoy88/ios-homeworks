
import UIKit

final class FeedViewController: UIViewController {
    
    var post = Post(title: "Мой пост")
    
    
    private lazy var nextPageButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        button.layer.cornerRadius = 16
        button.setTitle("Показать пост", for: .normal)
        button.setTitleColor(.systemYellow, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.backgroundColor = .systemIndigo
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .placeholderText
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
        navigationController?.pushViewController(postVC, animated: true)
    }
    @objc private func buttonAction() {
            let postViewController = PostViewController()
            self.navigationController?.pushViewController(postViewController, animated: true)
        postViewController.titlePost = post.title
        }
    

}
