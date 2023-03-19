//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Олег Мостовой on 16.03.2023.
//

import UIKit

final class PhotosTableViewCell: UITableViewCell {
    
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
    
    let imageView1: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 6
        $0.image = UIImage(named: "1")
        return $0
    }(UIImageView())
    
    let imageView2: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 6
        $0.image = UIImage(named: "2")
        return $0
    }(UIImageView())
    
    let imageView3: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 6
        $0.image = UIImage(named: "3")
        return $0
    }(UIImageView())
    
    let imageView4: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 6
        $0.image = UIImage(named: "4")
        return $0
    }(UIImageView())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        [photosTextLabel, goToGalleryButton, imageView1, imageView2, imageView3, imageView4].forEach { contentView.addSubview($0) }
        contentView.layer.borderWidth = 0
        let inset: CGFloat = 12
        let insetImage: CGFloat = 8
        let screenWidth = UIScreen.main.bounds.width
        let imageWidth = (screenWidth - 48) / 4
        let imageHeight = imageWidth / 4 * 3
        
        NSLayoutConstraint.activate([
            photosTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            photosTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            photosTextLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            goToGalleryButton.centerYAnchor.constraint(equalTo: photosTextLabel.centerYAnchor),
            goToGalleryButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            
            imageView1.topAnchor.constraint(equalTo: photosTextLabel.bottomAnchor, constant: inset),
            imageView1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            imageView1.widthAnchor.constraint(equalToConstant: imageWidth),
            imageView1.heightAnchor.constraint(equalToConstant: imageHeight),
            imageView1.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
            
            imageView2.topAnchor.constraint(equalTo: photosTextLabel.bottomAnchor, constant: inset),
            imageView2.leadingAnchor.constraint(equalTo: imageView1.trailingAnchor, constant: insetImage),
            imageView2.widthAnchor.constraint(equalToConstant: imageWidth),
            imageView2.heightAnchor.constraint(equalToConstant: imageHeight),
            imageView2.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
            
            imageView3.topAnchor.constraint(equalTo: photosTextLabel.bottomAnchor, constant: inset),
            imageView3.leadingAnchor.constraint(equalTo: imageView2.trailingAnchor, constant: insetImage),
            imageView3.widthAnchor.constraint(equalToConstant: imageWidth),
            imageView3.heightAnchor.constraint(equalToConstant: imageHeight),
            imageView3.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
            
            imageView4.topAnchor.constraint(equalTo: photosTextLabel.bottomAnchor, constant: inset),
            imageView4.widthAnchor.constraint(equalToConstant: imageWidth),
            imageView4.heightAnchor.constraint(equalToConstant: imageHeight),
            imageView4.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            imageView4.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])
    }
}
