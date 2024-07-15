//
//  PosterCollectionViewCell.swift
//  MoviePack
//
//  Created by 서충원 on 7/15/24.
//

import UIKit
import Then
import SnapKit

final class PosterCollectionViewCell: BaseCollectionViewCell {
    let posterImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    private lazy var gradientView = UIView().then {
        $0.backgroundColor = .clear
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(origin: .zero, size: CGSize(width: PosterCollectionViewCell.screenSize.width, height: 300))
        gradientLayer.colors = [UIColor.clear.cgColor, Colors.blackBackground.cgColor]
        $0.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func configureView() {
        contentView.backgroundColor = Colors.blackBackground
    }
    
    override func configureSubViews() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(gradientView)
    }
    
    override func configureConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        gradientView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(posterImageView)
            make.height.equalTo(300)
        }
    }
}

