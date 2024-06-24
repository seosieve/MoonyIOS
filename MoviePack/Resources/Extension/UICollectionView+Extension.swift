//
//  UICollectionView+Extension.swift
//  MoviePack
//
//  Created by 서충원 on 6/11/24.
//

import UIKit

extension UICollectionViewCell: ReusableProtocol {
    //Automatically Create Identifier
    static var identifier: String {
        return String(describing: self)
    }
}
