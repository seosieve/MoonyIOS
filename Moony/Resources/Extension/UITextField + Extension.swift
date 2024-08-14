//
//  UITextField + Extension.swift
//  Moony
//
//  Created by 서충원 on 6/11/24.
//

import UIKit

extension UITextField {
    func setPlaceholderColor(color: UIColor) {
        guard let placeholder = self.placeholder else { return }
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: color])
    }
}
