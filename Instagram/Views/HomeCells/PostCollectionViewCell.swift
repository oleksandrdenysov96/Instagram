//
//  PostCollectionViewCell.swift
//  Instagram
//
//  Created by Oleksandr Denysov on 17.12.2023.
//

import UIKit

protocol PostCollectionViewCellDelegate: AnyObject {
    func postCollectionViewCellDidLike(_ cell: PostCollectionViewCell)
}

final class PostCollectionViewCell: UICollectionViewCell {

    static let identifier = "PostCollectionViewCell"

    public weak var delegate: PostCollectionViewCellDelegate?

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let doubleTapLikeImage: UIImageView = {
        let image = UIImage(
            systemName: "suit.heart.fill",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 50)
        )
        let imageView = UIImageView(image: image)
        imageView.tintColor = .white
        imageView.isHidden = true
        imageView.alpha = 0
        return imageView
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        backgroundColor = .secondarySystemBackground
        contentView.addSubviews(views: imageView, doubleTapLikeImage)

        let tap = UITapGestureRecognizer(target: self, action: #selector(didDoubleTapImage))
        tap.numberOfTapsRequired = 2
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds

        let size = imageView.bounds.width / 2.2
        doubleTapLikeImage.frame = CGRect(
            x: (contentView.width - size) / 2, 
            y: (contentView.height - size) / 2,
            width: size + 30, height: size
        )
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }


    func configure(with viewModel: PostCollectionViewCellViewModel) {
        imageView.sd_setImage(with: viewModel.postURL)
    }

    @objc
    private func didDoubleTapImage() {

        UIView.animate(withDuration: 0.35) { [weak self] in
            self?.doubleTapLikeImage.isHidden = false
            self?.doubleTapLikeImage.alpha = 0.7
        } completion: { done in
            if done {
                UIView.animate(withDuration: 0.2) { [weak self] in
                    self?.doubleTapLikeImage.alpha = 0
                } completion: { done in
                    if done {
                        self.doubleTapLikeImage.isHidden = true
                    }
                }
            }
        }
        delegate?.postCollectionViewCellDidLike(self)
    }
}
