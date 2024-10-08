//
//  NSObjectProtocol + Extenstion.swift
//  Moony
//
//  Created by 서충원 on 7/13/24.
//

import UIKit

extension NSObjectProtocol {
    ///Instead of UIScreen.main
    static var screenSize: CGRect {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return CGRect() }
        return window.screen.bounds
    }
    
    ///SafeArea Inset
    static var safeArea: UIEdgeInsets {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene, let keyWindow = window.keyWindow else { return UIEdgeInsets() }
        return keyWindow.safeAreaInsets
    }
}
