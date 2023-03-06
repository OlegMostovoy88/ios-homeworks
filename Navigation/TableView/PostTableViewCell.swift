//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Олег Мостовой on 05.03.2023.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    private let postImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.systemGray.cgColor
        $0.backgroundColor = .black
        return $0
    }(UIImageView())
    
    private let authorText: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 2
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private let descriptionText: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .black
        $0.textAlignment = .justified
        return $0
    }(UILabel())
    
    private let likesText: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .black
        $0.numberOfLines = 1
        return $0
    }(UILabel())
    
    private let viewsText: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .black
        $0.numberOfLines = 1
        return $0
    }(UILabel())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        customizeCell()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupCell(post: Post) {
        authorText.text = post.author
        postImage.image = post.image
        descriptionText.text = post.description
        likesText.text = "Likes: \(post.likes)"
        viewsText.text = "Views: \(post.views)"
    }
    
    private func customizeCell() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.purple.cgColor
    }
    private func layout() {
        [authorText, postImage, descriptionText, likesText, viewsText].forEach { contentView.addSubview($0) }
        
        contentView.layer.borderWidth = 0
        let screenWidth = UIScreen.main.bounds.width
        let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
           
            authorText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            authorText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            authorText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            
            postImage.topAnchor.constraint(equalTo: authorText.bottomAnchor, constant: inset),
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImage.heightAnchor.constraint(equalToConstant: screenWidth),
            
            descriptionText.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: inset),
            descriptionText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            descriptionText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            
            likesText.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: inset),
            likesText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            likesText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
   
            viewsText.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: inset),
            viewsText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            viewsText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])
    }
}
