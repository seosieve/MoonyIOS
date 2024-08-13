//
//  PosterCollectionViewCell.swift
//  MoviePack
//
//  Created by 서충원 on 8/13/24.
//

import UIKit
import Kingfisher

final class PosterCollectionViewCell: BaseCollectionViewCell {
    
    private let posterImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        $0.isSkeletonable = true
        $0.showAnimatedGradientSkeleton()
    }
    
    override func configureView() {
        contentView.backgroundColor = Colors.blackBackground
    }
    
    override func configureSubViews() {
        contentView.addSubview(posterImageView)
    }
    
    override func configureConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureCell(_ poster: Poster) {
        ///Show Skeleton View
        posterImageView.showAnimatedGradientSkeleton()
        
        let url = URL(string: poster.posterUrl)
        posterImageView.kf.setImage(with: url) { [weak self] _ in
            ///Hide Skeleton View
            self?.posterImageView.stopSkeletonAnimation()
            self?.posterImageView.hideSkeleton()
        }
    }
}

