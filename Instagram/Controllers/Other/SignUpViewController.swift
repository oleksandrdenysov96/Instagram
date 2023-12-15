//
//  SignUpViewController.swift
//  Instagram
//
//  Created by Oleksandr Denysov on 14.12.2023.
//

import UIKit
import SafariServices

class SignUpViewController: AuthFlowViewController {

    private let profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.circle"))
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 45
        return imageView
    }()

    private let userNameField: IGTextField = {
        let field = IGTextField()
        field.placeholder = "Username"
        field.keyboardType = .default
        field.returnKeyType = .next
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        return field
    }()

    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Account"
        view.backgroundColor = .systemBackground
        view.addSubviews(
            views:
            profileImageView,
            userNameField,
            emailField,
            passwordField,
            signUpButton,
            termsButton,
            privacyButton
        )
        addImageGesture()
        userNameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        addButtonsActions()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let imageSize: CGFloat = 90

        profileImageView.frame = CGRect(
            x: (view.width - imageSize) / 2,
            y: view.safeAreaInsets.top + 40,
            width: imageSize, height: imageSize
        )

        userNameField.frame = CGRect(
            x: 25, y: Int(profileImageView.bottom) + 40,
            width: Int(view.width) - 50, height: 50
        )

        emailField.frame = CGRect(
            x: 25, y: Int(userNameField.bottom) + 13,
            width: Int(view.width) - 50, height: 50
        )
        passwordField.frame = CGRect(
            x: 25, y: Int(emailField.bottom) + 13,
            width: Int(view.width) - 50, height: 50
        )
        signUpButton.frame = CGRect(
            x: 40, y: Int(passwordField.bottom) + 33,
            width: Int(view.width) - 80, height: 50
        )
        termsButton.frame = CGRect(
            x: 50, y: Int(signUpButton.bottom) + 240,
            width: Int(view.width) - 100, height: 30
        )
        privacyButton.frame = CGRect(
            x: 50, y: Int(termsButton.bottom) + 10,
            width: Int(view.width) - 100, height: 30
        )
    }

    private func addImageGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(tap)

    }

    override internal func addButtonsActions() {
        super.addButtonsActions()
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
    }


    // MARK: Actions
    
    @objc
    private func didTapImage() {
        let sheet = UIAlertController(
            title: "Profile Picture", 
            message: "Show yourself to this world",
            preferredStyle: .actionSheet
        )

        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        sheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { [weak self] _ in
            DispatchQueue.main.async {
                let picker = UIImagePickerController()
                picker.allowsEditing = true
                picker.sourceType = .camera
                picker.delegate = self
                self?.present(picker, animated: true)
            }
        }))
        sheet.addAction(UIAlertAction(title: "Choose from gallery", style: .default, handler: { [weak self] _ in
            DispatchQueue.main.async {
                let picker = UIImagePickerController()
                picker.allowsEditing = true
                picker.sourceType = .photoLibrary
                picker.delegate = self
                self?.present(picker, animated: true)
            }
        }))
        present(sheet, animated: true)
    }

    @objc
    private func didTapSignUp() {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        userNameField.resignFirstResponder()

        guard let username = userNameField.text,
              let email = emailField.text,
              let password = passwordField.text,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              !username.trimmingCharacters(in: .whitespaces).isEmpty,
              password.count >= 6,
              username.count >= 3,
              username.trimmingCharacters(in: .alphanumerics).isEmpty
        else {
            presentSingleOptionErrorAlert(
                title: "Whoops!",
                message: "Please, enter a valid values in all fields",
                buttonTitle: "Got it"
            )
            return
        }

        // Sign up with AuthManager
    }
}


extension SignUpViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameField {
            emailField.becomeFirstResponder()
        }
        else if textField == emailField {
            passwordField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            didTapSignUp()
        }
        return true
    }
}

// MARK: Image Picker
extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:
                               [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        profileImageView.image = selectedImage
    }
}

