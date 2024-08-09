//
//  Images.swift
//  MoviePack
//
//  Created by 서충원 on 8/9/24.
//

import UIKit

enum Images {
    
    static let magnifier = UIImage(systemName: "magnifyingglass")
    static let ellipsis = UIImage(systemName: "ellipsis")
    
    static func profile(_ number: Int) -> UIImage? {
        return UIImage(named: "profile_\(number)")
    }
}
