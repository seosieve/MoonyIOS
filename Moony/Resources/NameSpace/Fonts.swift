//
//  Fonts.swift
//  Moony
//
//  Created by 서충원 on 8/4/24.
//

import UIKit

struct Fonts {
    static func stretch(_ size: Int) -> UIFont {
        return UIFont(name: "StretchProRegular", size: CGFloat(size))!
    }
    
    static func han(_ size: Int) -> UIFont {
        return UIFont(name: "BlackHanSans-Regular", size: CGFloat(size))!
    }
}
