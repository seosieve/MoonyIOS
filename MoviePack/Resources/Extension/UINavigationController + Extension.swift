//
//  UINavigationController + Extension.swift
//  MoviePack
//
//  Created by 서충원 on 7/14/24.
//

import UIKit

extension UINavigationController {
    func setNavigationAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
    }
}
