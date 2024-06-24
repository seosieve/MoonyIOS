//
//  UIView+Extension.swift
//  MoviePack
//
//  Created by 서충원 on 6/24/24.
//

import UIKit

extension UIView {
    // Keyboard Down When Tapped
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
}
