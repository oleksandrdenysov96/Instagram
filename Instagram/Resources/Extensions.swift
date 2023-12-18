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


extension Encodable {
    
    func asDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        let json = try? JSONSerialization.jsonObject(
            with: data,
            options: JSONSerialization.ReadingOptions.fragmentsAllowed
        ) as? [String: Any]
        return json
    }
}

extension Decodable {

    init?(with dictionary: [String: Any]) {
        guard let data = try? JSONSerialization.data(
            withJSONObject: dictionary, options: .prettyPrinted
        ) else {
            IGLogger.shared.debugInfo("decoder: unable to retrieve data from dictionary")
            return nil
        }
        guard let result = try? JSONDecoder().decode(Self.self, from: data) else {
            IGLogger.shared.debugInfo("decoder: unable to decode data")
            return nil
        }
        self = result
    }
}

extension DateFormatter {
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
}

extension String {
    static func date(from date: Date) -> String? {
        let formatter = DateFormatter.formatter
        let string = formatter.string(from: date)
        return string
    }
}
