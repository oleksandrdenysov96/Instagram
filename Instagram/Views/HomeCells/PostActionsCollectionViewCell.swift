//
//  PostActionsCollectionViewCell.swift
//  Instagram
//
//  Created by Oleksandr Denysov on 17.12.2023.
//

import UIKit

protocol PostActionsCollectionViewCellDelegate: AnyObject {
    func postActionsCollectionViewCellDidTapLike(_ cell: PostActionsCollectionViewCell, isLiked: Bool)
    func postActionsCollectionViewCellDidTapComment(_ cell: PostActionsCollectionViewCell)
    func postActionsCollectionViewCellDidTapShare(_ cell: PostActionsCollectionViewCell)
}

class PostActionsCollectionViewCell: UICollectionViewCell {
    static let identifier = "PostActionsCollectionViewCell"
    
    public weak var delegate: PostActionsCollectionViewCellDelegate?

    private var isLiked = false

    private let likeButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(
            systemName: "suit.heart",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 29)
        )
        button.setImage(image, for: .normal)
        return button
    }()

    private let commentButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(
            systemName: "message",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 27)

        )
        button.setImage(image, for: .normal)
        
        return button
    }()

    private let shareButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(
            systemName: "paperplane",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 27)
        )
        button.setImage(image, for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        backgroundColor = .systemBackground

        contentView.addSubviews(
            views: likeButton, commentButton, shareButton
        )

        likeButton.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(didTapComment), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let size: CGFloat = 30
        likeButton.frame = CGRect(
            x: 16, y: (contentView.height - size) / 1.2,
            width: size + 15, height: size
        )
        commentButton.frame = CGRect(
            x: likeButton.rigth + 6, y: (contentView.height - size) / 1.2,
            width: size + 15, height: size
        )
        shareButton.frame = CGRect(
            x: commentButton.rigth + 6, y: (contentView.height - size) / 1.2,
            width: size + 15, height: size
        )
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }


    func configure(with viewModel: PostActionsCollectionViewCellViewModel) {
        isLiked = viewModel.isLiked
        if viewModel.isLiked {
            let image = UIImage(
                systemName: "suit.heart.fill", 
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 29)
            )

            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.likeButton.setImage(image, for: .normal)
                self?.likeButton.tintColor = .systemRed
            }
        }
    }


    @objc
    private func didTapLike() {
        if isLiked {
            let image = UIImage(
                systemName: "suit.heart",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 29)
            )

            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.likeButton.tintColor = .label
                self?.likeButton.setImage(image, for: .normal)
            }
        }
        else {
            let image = UIImage(
                systemName: "suit.heart.fill", 
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 29)
            )

            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.likeButton.setImage(image, for: .normal)
                self?.likeButton.tintColor = .systemRed
            }
        }

        delegate?.postActionsCollectionViewCellDidTapLike(self, isLiked: !isLiked)
        isLiked = !isLiked
    }

    @objc
    private func didTapComment() {
        delegate?.postActionsCollectionViewCellDidTapComment(self)
    }

    @objc
    private func didTapShare() {
        delegate?.postActionsCollectionViewCellDidTapShare(self)
    }
}
