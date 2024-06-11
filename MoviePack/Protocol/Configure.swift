//
//  Configure.swift
//  MoviePack
//
//  Created by 서충원 on 6/11/24.
//

import UIKit
import SnapKit

protocol Configure: AnyObject {
    func setViews()
    func configureSubviews()
    func configureConstraints()
}
