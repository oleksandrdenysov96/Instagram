//
//  IGTextField.swift
//  Instagram
//
//  Created by Oleksandr Denysov on 15.12.2023.
//

import UIKit

class IGTextField: UITextField {


    override init(frame: CGRect) {
        super.init(frame: frame)
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        leftViewMode = .always
        layer.cornerRadius = 12
        layer.borderColor = UIColor.secondaryLabel.cgColor
        layer.borderWidth = 1
        backgroundColor = .secondarySystemBackground
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
