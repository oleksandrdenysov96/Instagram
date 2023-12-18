//
//  HomeFeedCellType.swift
//  Instagram
//
//  Created by Oleksandr Denysov on 17.12.2023.
//

import Foundation

enum HomeFeedCellType {
    case poster(viewModel: PosterCollectionViewCellViewModel)
    case post(viewModel: PostCollectionViewCellViewModel)
    case actions(viewModel: PostActionsCollectionViewCellViewModel)
    case likesCount(viewModel: PostLikesCollectionViewCellViewModel)
    case caption(viewModel: PostCaptionCollectionViewCellViewModel)
    case timeStamp(viewModel: PostDateTimeCollectionViewCellViewModel)
}
