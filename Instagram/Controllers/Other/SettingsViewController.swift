//
//  SettingsViewController.swift
//  Instagram
//
//  Created by Oleksandr Denysov on 14.12.2023.
//

import UIKit

class SettingsViewController: UIViewController {

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close, target: self, action: #selector(didTapClose)
        )
        tableView.delegate = self
        tableView.dataSource = self
        createTableFooter()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    @objc
    private func didTapClose() {
        dismiss(animated: true)
    }
}


extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {

    private func createTableFooter() {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 50))
        footer.clipsToBounds = true

        let button = UIButton(frame: footer.bounds)
        footer.addSubview(button)
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(didTapSignOut), for: .touchUpInside)

        tableView.tableFooterView = footer
    }

    @objc
    func didTapSignOut() {
        let actionSheet = UIAlertController(
            title: "Sign Out", message: "Arer you sure?", preferredStyle: .actionSheet
        )
        actionSheet.addAction(
            UIAlertAction(title: "Cancel", style: .cancel)
        )
        actionSheet.addAction(
            UIAlertAction(title: "Sign Out", style: .destructive, handler: { [weak self] _ in
            guard let self = self else { return }

            AuthManager.shared.signOut { success in
                if success {
                    DispatchQueue.main.async {
                        let signInVC = SignInViewController()
                        let navVC = UINavigationController(rootViewController: signInVC)
                        navVC.modalPresentationStyle = .fullScreen
                        self.present(navVC, animated: true)
                    }
                }
                else {
                    IGLogger.shared.debugInfo(
                        "end: Settings cotroller has ended with logout failure"
                    )
                }
            }
        })
        )
        present(actionSheet, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}
