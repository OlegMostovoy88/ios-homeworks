import UIKit

class PhotosViewController: UIViewController {
    
    private var model: [Int] {
        var array = [Int]()
        for index in 0...19 {
            array.append(index + 1)
        }
        return array
    }
    
    private lazy var goToTopButton: UIButton = {
        $0.backgroundColor = #colorLiteral(red: 0.535210073, green: 0.57391572, blue: 1, alpha: 1)
        $0.setTitle("Вверх", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowRadius = 4
        $0.layer.shadowOpacity = 0.7
        $0.layer.cornerRadius = 50
        $0.layer.shadowOffset = CGSize(width: 4, height: 4)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(goToTopButtonAction), for: .touchUpInside)
        return $0
    }(UIButton())
    
    @objc func goToTopButtonAction() {
        collectionView.setContentOffset(.zero, animated: true)
    }
    
    private var initialImageRect: CGRect = .zero
    
    
    
    
    
    
    private let transLucentView: UIView = {
        $0.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        $0.alpha = 0.7
        return $0
    }(UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    )
    
    private lazy var closeProfileImageButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        $0.addTarget(self, action: #selector(crossButtonAction), for: .touchUpInside)
        return $0
    }(UIButton())
    
    @objc private func crossButtonAction() {
        closeProfileImageButton.removeFromSuperview()
        transLucentView.removeFromSuperview()
        animateImageToInitial(rect: initialImageRect)
    }
    
    private let animatingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        return collectionView
    }()
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Photos"
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.backItem?.title = "Назад"
        
    }
    
    
    
    
    private func animateImageToInitial(rect: CGRect) {
        UIView.animate(withDuration: 0.6) {
            self.animatingImageView.frame = rect
            self.animatingImageView.layer.cornerRadius = 0
        } completion: { _ in
            self.animatingImageView.removeFromSuperview()
        }
    }
    
    private func animateImage(_ image: UIImage?, imageFrame: CGRect) {
        view.addSubview(transLucentView)
        view.addSubview(animatingImageView)
        view.addSubview(closeProfileImageButton)
        
        NSLayoutConstraint.activate([
            closeProfileImageButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            closeProfileImageButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
        
        animatingImageView.image = image
        animatingImageView.alpha = 1.0
        animatingImageView.frame = CGRect(x: imageFrame.origin.x,
                                          y: imageFrame.origin.y,
                                          width: imageFrame.width,
                                          height: imageFrame.height)
        
        UIView.animate(withDuration: 0.6) {
            let ratio = (self.animatingImageView.image?.size.height)! / (self.animatingImageView.image?.size.width)!
            let imageWidth = UIScreen.main.bounds.width
            let imageHeight = imageWidth * ratio
            if imageHeight > (0.75 * (UIScreen.main.bounds.height)) {
                self.animatingImageView.frame.size = CGSize(
                    width: ((0.75 * (UIScreen.main.bounds.height)) / ratio),
                    height: (0.75 * (UIScreen.main.bounds.height)))
                self.animatingImageView.center = self.view.center
            } else {
                self.animatingImageView.frame.size = CGSize(
                    width: imageWidth,
                    height: imageHeight)
                self.animatingImageView.center = self.view.center
            }
        }
    }
    
    private func layout() {
        view.addSubview(collectionView)
        view.addSubview(goToTopButton)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            goToTopButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -25),
            goToTopButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            goToTopButton.heightAnchor.constraint(equalToConstant: 100),
            goToTopButton.widthAnchor.constraint(equalToConstant: 100),
            
        ])
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        cell.setupCell()
        cell.photo.image = UIImage(named: "\(indexPath.item + 1)")
        cell.delegate = self
        cell.setIndexPath(indexPath)
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    private var sideInset: CGFloat { return 8 }
    private var elementCount: CGFloat { return 3 }
    private var insetsCount: CGFloat { return elementCount + 1 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - sideInset * insetsCount) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sideInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset, left: sideInset, bottom: .zero, right: sideInset)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let atributes = collectionView.layoutAttributesForItem(at: [0,0])
        let height = atributes!.size.height
        if collectionView.contentOffset.y < ((1 * height) / 4) {
            goToTopButton.isHidden = true
        } else {
            goToTopButton.isHidden = false
            var alpha = (collectionView.contentOffset.y)/100
            if alpha > 1 {
                alpha = 1
            }
            goToTopButton.alpha = alpha
        }
    }
}


extension PhotosViewController: CustomCollectionViewCellDelegate {
    func didTapImageInCell(_ image: UIImage?, frameImage: CGRect, indexPath: IndexPath) {
        let atributes = collectionView.layoutAttributesForItem(at: indexPath)
        let rectCell = atributes?.frame
        let rectInSuperView = collectionView.convert(rectCell!, to: collectionView.superview)
        initialImageRect = CGRect(x: frameImage.origin.x + rectInSuperView.origin.x,
                                  y: frameImage.origin.y + rectInSuperView.origin.y,
                                  width: frameImage.width,
                                  height: frameImage.height)
        
        animateImage(image, imageFrame: initialImageRect)
    }
}
