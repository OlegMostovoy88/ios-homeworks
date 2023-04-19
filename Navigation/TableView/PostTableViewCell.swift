import UIKit

protocol PostTableViewCellDelegate: AnyObject {
    func didTapImage(indexPath: IndexPath)
}

class PostTableViewCell: UITableViewCell {
    
    weak var delegate: PostTableViewCellDelegate?
    
    lazy var indexPathCell = IndexPath()
    
    private let contentWhiteView: UIView = {
        $0.backgroundColor = .systemBackground
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private let authorText: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 2
        $0.textAlignment = .left
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        return $0
    }(UILabel())
    
    lazy var postImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .black
        $0.contentMode = .scaleAspectFit
        $0.isUserInteractionEnabled = true
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(postImageAction)))
        return $0
    }(UIImageView())
    
    private let descriptionText: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .systemBackground
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textColor = #colorLiteral(red: 0.3143926263, green: 0.4061227441, blue: 1, alpha: 1)
        return $0
    }(UILabel())
    
    private lazy var likesText: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.textColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        $0.isUserInteractionEnabled = true
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(likesIncrease)))
        return $0
    }(UILabel())
    
    private let viewsText: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .black
        return $0
    }(UILabel())
    
    @objc func postImageAction(){
        delegate?.didTapImage(indexPath: indexPathCell)
    }
    
    @objc func likesIncrease(){
        post[indexPathCell.row].likes += 1
        likesText.text = "❤️ \(post[indexPathCell.row].likes)"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        authorText.text = ""
        postImageView.image = nil
        descriptionText.text = ""
        likesText.text = ""
        viewsText.text = ""
    }
    
    func setupCell(indexPath: IndexPath) {
        indexPathCell = indexPath
        authorText.text = post[indexPathCell.row].author
        postImageView.image = post[indexPathCell.row].image
        descriptionText.text = post[indexPathCell.row].description
        likesText.text = "❤️ \(post[indexPathCell.row].likes)"
        viewsText.text = "👁️ \(post[indexPathCell.row].views)"
        viewsText.textColor = #colorLiteral(red: 0.4387462437, green: 0.1898157895, blue: 0.8523948789, alpha: 1)
    }
    
    private func layout() {
        contentView.addSubview(authorText)
        contentView.addSubview(postImageView)
        contentView.addSubview(descriptionText)
        contentView.addSubview(likesText)
        contentView.addSubview(viewsText)
        
        NSLayoutConstraint.activate([
            
            authorText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metric.inset),
            authorText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metric.inset),
            authorText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metric.inset),
            
            postImageView.topAnchor.constraint(equalTo: authorText.bottomAnchor, constant: Metric.inset),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            
            descriptionText.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: Metric.inset),
            descriptionText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metric.inset),
            descriptionText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metric.inset),
            
            likesText.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: Metric.top),
            likesText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metric.inset),
            likesText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Metric.inset),
            
            viewsText.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: Metric.top),
            viewsText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metric.inset),
            viewsText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Metric.inset),
        ])
    }
}

extension PostTableViewCell {
    enum Metric {
        static let inset: CGFloat = 16
        static let top: CGFloat = 10
    }
}
