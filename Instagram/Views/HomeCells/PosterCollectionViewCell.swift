//
//  PosterCollectionViewCell.swift
//  Instagram
//
//  Created by Oleksandr Denysov on 17.12.2023.
//

import SDWebImage
import UIKit
import Foundation


protocol PosterCollectionViewCellDelegate: AnyObject {
    func posterCollectionViewCellDidTapMoreOptions(_ cell: PosterCollectionViewCell)
    func posterCollectionViewCellDidTapUsername(_ cell: PosterCollectionViewCell)
}

final class PosterCollectionViewCell: UICollectionViewCell {
    static let identifier = "PosterCollectionViewCell"

    public weak var delegate: PosterCollectionViewCellDelegate?

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.isUserInteractionEnabled = true
        return label
    }()

    private let moreOptionsButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(
            systemName: "ellipsis", 
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 23)
        )
        button.setImage(image, for: .normal)
        return button
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        backgroundColor = .systemBackground
        contentView.addSubviews(views: imageView, usernameLabel, moreOptionsButton)
        moreOptionsButton.addTarget(self, action: #selector(didTapMore), for: .touchUpInside)

        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapUsername))
        usernameLabel.addGestureRecognizer(tap)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let imageSize = contentView.height - 16
        imageView.frame = CGRect(
            x: 18, y: 7, width: imageSize, height: imageSize
        )
        imageView.layer.cornerRadius = imageSize / 2

        usernameLabel.sizeToFit()
        usernameLabel.frame = CGRect(
            x: imageView.rigth + 20, y: 0,
            width: usernameLabel.width, height: contentView.height
        )

        moreOptionsButton.frame = CGRect(
            x: contentView.width - 70,
            y: (contentView.height - 60) / 2,
            width: 60, height: 60
        )
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        usernameLabel.text = nil
        imageView.image = nil
    }


    func configure(with viewModel: PosterCollectionViewCellViewModel) {
        imageView.sd_setImage(with: viewModel.profilePictureURL)
        usernameLabel.text = viewModel.username
    }

    @objc
    private func didTapUsername() {
        delegate?.posterCollectionViewCellDidTapUsername(self)
    }

    @objc
    private func didTapMore() {
        delegate?.posterCollectionViewCellDidTapMoreOptions(self)
    }
}
