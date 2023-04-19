import UIKit

class InfoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1312785149, green: 0.03987477347, blue: 0.3262543678, alpha: 1)
        setupButton()
    }
    
    private lazy var backButton: UIButton = {
        $0.layer.cornerRadius = 16
        $0.setTitle("Покинуть?", for: .normal)
        $0.setTitleColor(.systemYellow, for: .highlighted)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        $0.backgroundColor = #colorLiteral(red: 0.1626194715, green: 0.04926132411, blue: 0.4024096727, alpha: 1)
        $0.layer.shadowColor = UIColor.systemYellow.cgColor
        $0.layer.shadowRadius = 4
        $0.layer.shadowOpacity = 0.7
        $0.layer.shadowOffset = CGSize(width: 4, height: 4)
        return $0
    }(UIButton(frame: CGRect(x: 0, y: 0, width: 300, height: 50)))
    
    private func setupButton() {
        view.addSubview(backButton)
        backButton.center = view.center
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
    }
    
    
    @objc private func backAction() {
        let alert = UIAlertController(title: "Вы точно хотите выйти?", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Выйти", style: .cancel) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
