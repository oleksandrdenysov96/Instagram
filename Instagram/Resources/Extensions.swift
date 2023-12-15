//
//  Extensions.swift
//  Instagram
//
//  Created by Oleksandr Denysov on 15.12.2023.
//

import Foundation
import UIKit

extension UIView {

    var top: CGFloat {
        frame.origin.y
    }

    var left: CGFloat {
        frame.origin.x
    }

    var rigth: CGFloat {
        frame.origin.x + width
    }

    var bottom: CGFloat {
        frame.origin.y + height
    }

    var width: CGFloat {
        frame.size.width
    }

    var height: CGFloat {
        frame.size.height
    }

    func addSubviews(views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}

extension UIViewController {

    func presentSingleOptionErrorAlert(title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .cancel))
        present(alert, animated: true)
    }
}
