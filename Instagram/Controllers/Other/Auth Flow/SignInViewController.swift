//
//  SignInViewController.swift
//  Instagram
//
//  Created by Oleksandr Denysov on 14.12.2023.
//

import UIKit
import SafariServices

class SignInViewController: AuthFlowViewController {

    // Subviews:

    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12
        return button
    }()

    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.link, for: .normal)
        button.setTitle("Create Account", for: .normal)
        return button
    }()

    private let headerView = SignInHeaderView()


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign in"
        view.backgroundColor = .systemBackground
        view.addSubviews(
            views: headerView,
            emailField,
            passwordField,
            signInButton,
            createAccountButton,
            termsButton,
            privacyButton
        )
        emailField.delegate = self
        passwordField.delegate = self
        addButtonsActions()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerView.frame = CGRect(
            x: 0, y: view.safeAreaInsets.top,
            width: view.width, height: (
                view.height - view.safeAreaInsets.top
            ) / 3
        )
        emailField.frame = CGRect(
            x: 25, y: Int(headerView.bottom) + 40,
            width: Int(view.width) - 50, height: 50
        )
        passwordField.frame = CGRect(
            x: 25, y: Int(emailField.bottom) + 13,
            width: Int(view.width) - 50, height: 50
        )
        signInButton.frame = CGRect(
            x: 40, y: Int(passwordField.bottom) + 33,
            width: Int(view.width) - 80, height: 50
        )
        createAccountButton.frame = CGRect(
            x: 40, y: Int(signInButton.bottom) + 20,
            width: Int(view.width) - 80, height: 50
        )
        termsButton.frame = CGRect(
            x: 50, y: Int(createAccountButton.bottom) + 80,
            width: Int(view.width) - 100, height: 40
        )
        privacyButton.frame = CGRect(
            x: 50, y: Int(termsButton.bottom) + 10,
            width: Int(view.width) - 100, height: 40
        )
    }


    // MARK: Actions

    override internal func addButtonsActions() {
        super.addButtonsActions()
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccount), for: .touchUpInside)
    }

    @objc
    private func didTapSignIn() {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()

        guard let email = emailField.text,
              let password = passwordField.text,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              password.count >= 6 else {
            return
        }

        // Sign in with AuthManager

        AuthManager.shared.signIn(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    let vc = TabBarViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(vc, animated: true)

                case .failure(let failure):
                    IGLogger.shared.debugInfo("end: sign in vc end with log in error")
                }
            }
        }
    }

    @objc
    private func didTapCreateAccount() {
        let vc = SignUpViewController()
        vc.completion = {
            DispatchQueue.main.async { [weak self] in
                let tabVC = TabBarViewController()
                tabVC.modalPresentationStyle = .fullScreen
                self?.present(tabVC, animated: true)
            }
        }

        navigationController?.pushViewController(vc, animated: true)
    }
}


extension SignInViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            didTapSignIn()
        }
        return true
    }
}
