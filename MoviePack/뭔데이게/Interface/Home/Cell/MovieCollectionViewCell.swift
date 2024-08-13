//
//  MovieCollectionViewCell.swift
//  MoviePack
//
//  Created by 서충원 on 7/13/24.
//

import UIKit
import Kingfisher

final class MovieCollectionViewCell: BaseCollectionViewCell {
    
    private let movieImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        $0.isSkeletonable = true
        $0.showAnimatedGradientSkeleton()
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "title"
        $0.font = .boldSystemFont(ofSize: 15)
        $0.textColor = Colors.blackDescription
    }

    private let engTitleLabel = UILabel().then {
        $0.text = "english title"
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = Colors.blackContent
        $0.numberOfLines = 2
    }
    
    override func configureView() {
        contentView.backgroundColor = Colors.blackBackground
    }
    
    override func configureSubViews() {
        contentView.addSubview(movieImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(engTitleLabel)
    }
    
    override func configureConstraints() {
        movieImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(180)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(movieImageView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(2)
        }
        
        engTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(2)
        }
    }
    
    func configureCell(_ trend: BaseType) {
        ///Show Skeleton View
        movieImageView.showAnimatedGradientSkeleton()
        
        let url = URL(string: trend.imageUrl)
        movieImageView.kf.setImage(with: url) { [weak self] _ in
            ///Hide Skeleton View
            self?.movieImageView.stopSkeletonAnimation()
            self?.movieImageView.hideSkeleton()
        }
        
        titleLabel.text = trend.name
        engTitleLabel.text = trend.originalName
    }
}
