//
//  AuthFlowViewController.swift
//  Instagram
//
//  Created by Oleksandr Denysov on 15.12.2023.
//

import UIKit
import SafariServices

class AuthFlowViewController: UIViewController {

    // Subviews:
    internal let emailField: IGTextField = {
        let field = IGTextField()
        field.placeholder = "Email Adress"
        field.keyboardType = .emailAddress
        field.returnKeyType = .next
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        return field
    }()

    internal let passwordField: IGTextField = {
        let field = IGTextField()
        field.placeholder = "Password"
        field.keyboardType = .default
        field.returnKeyType = .continue
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.isSecureTextEntry = true
        return field
    }()

    internal let termsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.link, for: .normal)
        button.setTitle("Terms of Service", for: .normal)
        return button
    }()

    internal let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.link, for: .normal)
        button.setTitle("Privacy Policy", for: .normal)
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(
            views:
                emailField,
            passwordField,
            termsButton,
            privacyButton
        )
        addButtonsActions()
    }


    // MARK: Actions

    internal func addButtonsActions() {
        termsButton.addTarget(self, action: #selector(didTapTerms), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacy), for: .touchUpInside)
    }

    @objc
    internal func didTapTerms() {
        guard let url = URL(string: "https://www.instagram.com") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }

    @objc
    internal func didTapPrivacy() {
        guard let url = URL(string: "https://www.instagram.com") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)

    }

}
