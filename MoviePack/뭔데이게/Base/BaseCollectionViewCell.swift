//
//  BaseCollectionViewCell.swift
//  MoviePack
//
//  Created by 서충원 on 7/13/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureSubViews()
        configureConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() { }

    func configureSubViews() { }

    func configureConstraints() { }
}
