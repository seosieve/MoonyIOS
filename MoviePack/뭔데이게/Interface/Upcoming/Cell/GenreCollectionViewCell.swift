//
//  GenreCollectionViewCell.swift
//  MoviePack
//
//  Created by 서충원 on 8/10/24.
//

import UIKit

class GenreCollectionViewCell: BaseCollectionViewCell {
    
    private let genreBackgroundView = UIView().then {
        $0.backgroundColor = Colors.blackInterface
        $0.layer.cornerRadius = 30
    }
    
    override func configureView() {
        contentView.backgroundColor = .clear
    }
    
    override func configureSubViews() {
        contentView.addSubview(genreBackgroundView)
    }
    
    override func configureConstraints() {
        genreBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
