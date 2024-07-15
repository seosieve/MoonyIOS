//
//  NSObjectProtocol + Extenstion.swift
//  MoviePack
//
//  Created by 서충원 on 7/13/24.
//

import UIKit

extension NSObjectProtocol {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var screenSize: CGRect {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return CGRect() }
        return window.screen.bounds
    }
}
