import UIKit

protocol CustomCollectionViewCellDelegate: AnyObject {
    
    func didTapImageInCell(_ image: UIImage?, frameImage: CGRect, indexPath: IndexPath)
}

final class CollectionViewCell: UICollectionViewCell {
    
    weak var delegate: CustomCollectionViewCellDelegate?
    private var indexPathCell = IndexPath()
    
    lazy var photo: UIImageView = {
        $0.image = UIImage(named: "1")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = true
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction)))
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    @objc private func tapAction() {
        delegate?.didTapImageInCell(photo.image, frameImage: photo.frame, indexPath: indexPathCell)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setIndexPath(_ indexPath: IndexPath) {
        indexPathCell = indexPath
    }
    
    func setupCell() {
        contentView.addSubview(photo)
        backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            photo.topAnchor.constraint(equalTo: contentView.topAnchor),
            photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}
