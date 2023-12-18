//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Oleksandr Denysov on 14.12.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    private let user: User

    private var isCurrentUser: Bool {
        return user.username.lowercased()
            .elementsEqual(
                UserDefaults.standard.string(forKey: "username")?.lowercased() ?? ""
            )
    }

    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = user.username
        configure()
    }

    private func configure() {
        if isCurrentUser {
            let image = UIImage(systemName: "gear")?.withTintColor(.label)
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: image,
                style: .plain,
                target: self,
                action: #selector(didTapSettings)
            )
        }
    }

    @objc
    private func didTapSettings() {
        let vc = SettingsViewController()
        present(UINavigationController(rootViewController: vc), animated: true)
    }

}
