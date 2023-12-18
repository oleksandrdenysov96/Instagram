//
//  PostCaptionsCollectionViewCell.swift
//  Instagram
//
//  Created by Oleksandr Denysov on 17.12.2023.
//

import UIKit

class PostCaptionsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PostCaptionsCollectionViewCell"

    private let captionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        backgroundColor = .systemBackground
        contentView.addSubview(captionLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let size = captionLabel.sizeThatFits(contentView.bounds.size)
        captionLabel.frame = CGRect(
            x: 20, y: 0, width: contentView.bounds.width, height: contentView.bounds.height
        )
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        captionLabel.text = nil
    }


    func configure(with viewModel: PostCaptionCollectionViewCellViewModel) {
        if let caption = viewModel.caption {
            captionLabel.text = "\(viewModel.username): \(caption)"
        }
    }
}
