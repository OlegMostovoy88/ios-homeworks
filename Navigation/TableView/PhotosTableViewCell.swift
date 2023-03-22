//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Олег Мостовой on 16.03.2023.
//

import UIKit

final class PhotosTableViewCell: UITableViewCell {
    
    let source: [Photo] = Source.makePhoto()
    
    let photosTextLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Photos"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return $0
    }(UILabel())
    
    var goToGalleryButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        $0.tintColor = .black
        return $0
    }(UIButton())
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        return collectionView
    }()
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.clipsToBounds = false
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        [photosTextLabel, goToGalleryButton, collectionView].forEach { contentView.addSubview($0) }
        let inset: CGFloat = 12
        let screenWidth = UIScreen.main.bounds.width
        let imageWidth = (screenWidth - 120) / 2
        let imageHeight = imageWidth / 4 * 3
        
        NSLayoutConstraint.activate([
            photosTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            photosTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            photosTextLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            goToGalleryButton.centerYAnchor.constraint(equalTo: photosTextLabel.centerYAnchor),
            goToGalleryButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            
            collectionView.topAnchor.constraint(equalTo: photosTextLabel.topAnchor, constant: 2.2 * inset),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
            collectionView.widthAnchor.constraint(equalToConstant: imageWidth),
            collectionView.heightAnchor.constraint(equalToConstant: imageHeight),
        ])
    }
}

extension PhotosTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        source.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setupCell()
        cell.imageView.image = UIImage(named: source[indexPath.item].imageName)
        cell.contentView.layer.cornerRadius = 6
        cell.contentView.layer.borderColor = UIColor.purple.withAlphaComponent(0.3).cgColor
        cell.contentView.layer.borderWidth = 2

        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.purple.withAlphaComponent(0.3).cgColor
        border.frame = CGRect(x: 0, y: cell.contentView.frame.size.height - width, width:  cell.contentView.frame.size.width, height: cell.contentView.frame.size.height)

        border.borderWidth = width
        cell.contentView.layer.addSublayer(border)
        cell.contentView.layer.masksToBounds = true
        cell.contentView.clipsToBounds = true
        return cell
    }
    
}

extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout {
    private var sideInset: CGFloat { return 8 }
    private var elementCount: CGFloat { return 4}
    private var insetsCount: CGFloat { return elementCount + 1}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = (collectionView.bounds.width - sideInset * insetsCount) / elementCount
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sideInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset , left: sideInset, bottom: .zero, right: sideInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
}
