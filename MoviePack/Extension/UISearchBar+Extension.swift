//
//  UISearchBar+Extension.swift
//  MoviePack
//
//  Created by 서충원 on 6/11/24.
//

import UIKit

extension UISearchBar {
    func setSearchTextFieldItemColor(to color: UIColor) {
        if let textField = self.value(forKey: "searchField") as? UITextField {
            guard let leftView = textField.leftView as? UIImageView else { return }
            leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
            leftView.tintColor = color
            let attr = NSAttributedString(string: textField.placeholder ?? "", attributes: [.foregroundColor: color])
            textField.attributedPlaceholder = attr
        }
    }
}
