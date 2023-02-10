
import UIKit

final class ProfileViewController: UIViewController {
    
    private let textForLabel: String?
    
    private let myLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 100, width: 350, height: 40))
        label.backgroundColor = .systemIndigo
        return label
    }()
    
    init(textForLabel: String? = "Ваш Профиль") {
        self.textForLabel = textForLabel
        super.init(nibName: nil, bundle: nil)
        myLabel.text = textForLabel
        myLabel.textColor = .systemYellow
        myLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        myLabel.textAlignment = .center

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .placeholderText
        view.addSubview(myLabel)
        title = textForLabel
    }
}
