//
//  UINavigationController + Extension.swift
//  MoviePack
//
//  Created by 서충원 on 7/14/24.
//

import UIKit

extension UINavigationController {
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    ///Swipe Pop Action
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
