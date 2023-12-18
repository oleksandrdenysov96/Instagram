//
//  PostLikesCollectionViewCell.swift
//  Instagram
//
//  Created by Oleksandr Denysov on 17.12.2023.
//

import UIKit

protocol PostLikesCollectionViewCellDelegate: AnyObject {
    func postLikesCollectionViewCellDidTapLikeLabel(_ cell: PostLikesCollectionViewCell)
}

class PostLikesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PostLikesCollectionViewCell"

    public weak var delegate: PostCollectionViewCellDelegate?

    private let likesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        backgroundColor = .systemBackground
        addSubview(likesLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        likesLabel.frame = CGRect(
            x: 23, y: 0, width: contentView.width / 2, height: contentView.height
        )
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        likesLabel.text = nil
    }


    func configure(with viewModel: PostLikesCollectionViewCellViewModel) {
        let users = viewModel.likers
        likesLabel.text = users.count > 1 ? "\(users.count) likes" : "\(users.count) like"
    }
}
