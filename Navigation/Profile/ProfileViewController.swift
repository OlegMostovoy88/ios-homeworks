import UIKit

final class ProfileViewController: UIViewController {
    
    private var model:[[Any]]  = [["Photos"], post]
    
    private lazy var myRefreshControl: UIRefreshControl = {
        let title = NSLocalizedString("Обновление", comment: "Потяните, чтобы обновить")
        $0.attributedTitle = NSAttributedString(string: title)
        $0.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return $0
    }(UIRefreshControl())
    
    @objc func refresh(sender: UIRefreshControl) {
        post = postBackup
        tableView.reloadData()
        sender.endRefreshing()
    }
    
    private lazy var tableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.dataSource = self
        $0.delegate = self
        $0.sectionFooterHeight = 0
        $0.sectionHeaderHeight = 0
        $0.isUserInteractionEnabled = true
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissInput)))
        $0.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier )
        $0.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier )
        return $0
    }(UITableView(frame: .zero, style: .grouped))
    
    @objc private func arrowButtonAction() {
        navigationController?.pushViewController(PhotosViewController(), animated: true)
    }
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Тот самый профиль"
        view.backgroundColor = .white
        view.layer.cornerCurve = .circular
        tableView.refreshControl = myRefreshControl
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.tabBarController?.tabBar.isHidden = false
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        globalVCIndex = 0
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        globalVCIndex = nil
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
    func scrollToTop() {
        tableView.setContentOffset(.zero, animated: true)
    }
    
    private func layout() {
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}


extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return post.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath) as! PhotosTableViewCell
            cell.goToGalleryButton.addTarget(self, action: #selector(arrowButtonAction), for: .touchUpInside)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
            cell.setupCell(indexPath: indexPath)
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return ProfileHeaderView()
        } else {
            return nil
        }
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return UITableView.automaticDimension
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            post.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
}

extension ProfileViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    @objc func dismissInput() {
        view.endEditing(true)
    }
}

extension ProfileViewController: PostTableViewCellDelegate {
    func didTapImage(indexPath: IndexPath) {
        navigationController?.pushViewController(ViewPostViewController(), animated: true)
        globalIndexPath = indexPath
    }
}

extension ProfileViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if tabBarController.selectedIndex == 0 && globalVCIndex == 0 {
            scrollToTop()
        }
    }
}
