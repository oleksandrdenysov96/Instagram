//
//  PostDateTimeCollectionViewCell.swift
//  Instagram
//
//  Created by Oleksandr Denysov on 17.12.2023.
//

import UIKit

class PostDateTimeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PostDateTimeCollectionViewCell"

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        backgroundColor = .systemBackground
        addSubview(dateLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        dateLabel.frame = CGRect(
            x: 20, y: 0, width: contentView.width / 2, height: contentView.height
        )
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text = nil
    }


    func configure(with viewModel: PostDateTimeCollectionViewCellViewModel) {
        let date = viewModel.date
        dateLabel.text = .date(from: date)
    }
}
