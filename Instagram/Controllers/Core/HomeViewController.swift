//
//  HomeViewController.swift
//  Instagram
//
//  Created by Oleksandr Denysov on 14.12.2023.
//

import UIKit

class HomeViewController: UIViewController {


    private var collectionView: UICollectionView?
    private var viewModels = [[HomeFeedCellType]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Instagram"
        fetchPosts()
        configureCollectionView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds

    }

    // MARK: MOCKED DATA
    private func fetchPosts() {
        
        let mockModels: [HomeFeedCellType] = [
            .poster(viewModel: PosterCollectionViewCellViewModel(username: "_mocked_user_bulbasaur", profilePictureURL: URL(string: "https://upload.wikimedia.org/wikipedia/sh/thumb/4/43/Bulbasaur.png/1200px-Bulbasaur.png")!)),
            .post(viewModel: PostCollectionViewCellViewModel(postURL: URL(string: "https://static.wikia.nocookie.net/pokemon/images/1/19/Ash_Bulbasaur.png/revision/latest?cb=20230211060446")!)),
            .actions(viewModel: PostActionsCollectionViewCellViewModel(isLiked: true)),
            .likesCount(viewModel: PostLikesCollectionViewCellViewModel(likers: ["iosAcademy"])),
            .caption(viewModel: PostCaptionCollectionViewCellViewModel(username: "iosAcademy", caption: "Nice!")),
            .timeStamp(viewModel: PostDateTimeCollectionViewCellViewModel(date: Date()))
        ]

        self.viewModels.append(mockModels)
        collectionView?.reloadData()
    }

}


extension HomeViewController: PosterCollectionViewCellDelegate {
    func posterCollectionViewCellDidTapMoreOptions(_ cell: PosterCollectionViewCell) {
        let sheet = UIAlertController(title: "Post Actions", message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        sheet.addAction(UIAlertAction(title: "Share", style: .default))
        sheet.addAction(UIAlertAction(title: "Report", style: .destructive))
        present(sheet, animated: true)
    }
    
    func posterCollectionViewCellDidTapUsername(_ cell: PosterCollectionViewCell) {
        let vc = ProfileViewController(user: User(username: "_bulbasaur", email: "bulb@gmail.com"))
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: PostActionsCollectionViewCellDelegate {
    func postActionsCollectionViewCellDidTapLike(_ cell: PostActionsCollectionViewCell, isLiked: Bool) {
        // call to DB for like update
    }
    
    func postActionsCollectionViewCellDidTapComment(_ cell: PostActionsCollectionViewCell) {
        let vc = PostViewController()
        vc.title = "Some Post"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func postActionsCollectionViewCellDidTapShare(_ cell: PostActionsCollectionViewCell) {
        let vc = UIActivityViewController(
            activityItems: ["Sharing from instagram"], applicationActivities: []
        )
        present(vc, animated: true)
    }
    

}

extension HomeViewController: PostCollectionViewCellDelegate {
    func postCollectionViewCellDidLike(_ cell: PostCollectionViewCell) {
        print("like double tap on image cell")
    }
}

// MARK: COLLECTION VIEW SETUP/DELEGATE/DATA SOURCE

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellType = viewModels[indexPath.section][indexPath.row]
        switch cellType {

        case .poster(viewModel: let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath
            ) as? PosterCollectionViewCell else {
                IGLogger.shared.debugInfo("end: poster cell cannot be created")
                fatalError()
            }
            cell.delegate = self
            cell.configure(with: viewModel)
            return cell

        case .post(viewModel: let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PostCollectionViewCell.identifier, for: indexPath
            ) as? PostCollectionViewCell else {
                IGLogger.shared.debugInfo("end: poster cell cannot be created")
                fatalError()
            }
            cell.delegate = self
            cell.configure(with: viewModel)
            return cell

        case .actions(viewModel: let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PostActionsCollectionViewCell.identifier, for: indexPath
            ) as? PostActionsCollectionViewCell else {
                IGLogger.shared.debugInfo("end: poster cell cannot be created")
                fatalError()
            }
            cell.delegate = self
            cell.configure(with: viewModel)
            return cell

        case .likesCount(viewModel: let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PostLikesCollectionViewCell.identifier, for: indexPath
            ) as? PostLikesCollectionViewCell else {
                IGLogger.shared.debugInfo("end: poster cell cannot be created")
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell

        case .caption(viewModel: let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PostCaptionsCollectionViewCell.identifier, for: indexPath
            ) as? PostCaptionsCollectionViewCell else {
                IGLogger.shared.debugInfo("end: poster cell cannot be created")
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell

        case .timeStamp(viewModel: let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PostDateTimeCollectionViewCell.identifier, for: indexPath
            ) as? PostDateTimeCollectionViewCell else {
                IGLogger.shared.debugInfo("end: poster cell cannot be created")
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell
        }

    }


    private func configureCollectionView() {

        let sectionHeight: CGFloat = 395 + view.width

        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewCompositionalLayout(
                sectionProvider: { index, _ -> NSCollectionLayoutSection? in
                    let posterItem = NSCollectionLayoutItem(
                        layoutSize: NSCollectionLayoutSize(
                            widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60)
                        )
                    )

                    let postItem = NSCollectionLayoutItem(
                        layoutSize: NSCollectionLayoutSize(
                            widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.65)
                        )
                    )
                    
                    let actionsItem = NSCollectionLayoutItem(
                        layoutSize: NSCollectionLayoutSize(
                            widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(47)
                        )
                    )
                    
                    let likesCountItem = NSCollectionLayoutItem(
                        layoutSize: NSCollectionLayoutSize(
                            widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(36)
                        )
                    )

                    let captionItem = NSCollectionLayoutItem(
                        layoutSize: NSCollectionLayoutSize(
                            widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40)
                        )
                    )

                    let timestampItem = NSCollectionLayoutItem(
                        layoutSize: NSCollectionLayoutSize(
                            widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30)
                        )
                    )

                    let group = NSCollectionLayoutGroup.vertical(
                        layoutSize: NSCollectionLayoutSize(
                            widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(sectionHeight)),
                        subitems: [posterItem, postItem, actionsItem, likesCountItem, captionItem, timestampItem]
                    )

                    return NSCollectionLayoutSection(group: group)
                }
            )
         )

        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier
        )
        collectionView.register(
            PostCollectionViewCell.self, forCellWithReuseIdentifier: PostCollectionViewCell.identifier
        )
        collectionView.register(
            PostActionsCollectionViewCell.self, forCellWithReuseIdentifier: PostActionsCollectionViewCell.identifier
        )
        collectionView.register(
            PostLikesCollectionViewCell.self, forCellWithReuseIdentifier: PostLikesCollectionViewCell.identifier
        )
        collectionView.register(
            PostCaptionsCollectionViewCell.self, forCellWithReuseIdentifier: PostCaptionsCollectionViewCell.identifier
        )
        collectionView.register(
            PostDateTimeCollectionViewCell.self, forCellWithReuseIdentifier: PostDateTimeCollectionViewCell.identifier
        )

        self.collectionView = collectionView
    }
}

