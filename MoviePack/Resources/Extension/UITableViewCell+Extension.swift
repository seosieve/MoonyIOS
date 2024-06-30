//
//  UITableViewCell+Extension.swift
//  MoviePack
//
//  Created by 서충원 on 6/6/24.
//

import UIKit

extension UITableViewCell {
    //Animation when TableView Selected
    func selectionAnimation() {
        if self.isSelected {
            UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve) {
                self.setSelected(false, animated: true)
            }
        }
    }
}
