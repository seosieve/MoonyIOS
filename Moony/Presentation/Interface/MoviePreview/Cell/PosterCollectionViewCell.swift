//
//  PosterCollectionViewCell.swift
//  Moony
//
//  Created by 서충원 on 8/13/24.
//

import UIKit
import Kingfisher

final class PosterCollectionViewCell: BaseCollectionViewCell {
    
    private let backgroundImageView = UIImageView().then {
        $0.backgroundColor = Colors.blackInterface
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
    }
    
    private let backgroundVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    private let posterImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Colors.blackDescription.cgColor
        $0.isSkeletonable = true
        $0.showAnimatedGradientSkeleton()
    }
    
    override func configureView() {
        contentView.backgroundColor = Colors.blackBackground
    }
    
    override func configureSubViews() {
        contentView.addSubview(backgroundImageView)
        backgroundImageView.addSubview(backgroundVisualEffectView)
        contentView.addSubview(posterImageView)
    }
    
    override func configureConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backgroundVisualEffectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        posterImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(180)
        }
    }
    
    func configureCell(_ poster: Poster) {
        ///Show Skeleton View
        posterImageView.showAnimatedGradientSkeleton()
        
        let url = URL(string: poster.posterUrl)
        backgroundImageView.kf.setImage(with: url)
        posterImageView.kf.setImage(with: url) { [weak self] _ in
            ///Hide Skeleton View
            self?.posterImageView.stopSkeletonAnimation()
            self?.posterImageView.hideSkeleton()
        }
    }
}

