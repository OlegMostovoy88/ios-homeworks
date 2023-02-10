
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
//        makeBarItem()
    }
    
    private func setupButton() {
        view.addSubview(nextPageButton)
        nextPageButton.center = view.center
        nextPageButton.addTarget(self, action: #selector(tapActionTwo), for: .touchUpInside)
    }
    
//    private func makeBarItem() {
//        let barItem = UIBarButtonItem(title: "Дальше", style: .plain, target: self, action: #selector(buttonAction))
//        navigationItem.rightBarButtonItem = barItem
//    }
    
//    @objc private func tapAction() {
//        let secondVC = ProfileViewController(textForLabel: "Что у вас нового?")
//        secondVC.title = "Second VC"
//
//        navigationController?.pushViewController(secondVC, animated: true)
//    }
    
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
