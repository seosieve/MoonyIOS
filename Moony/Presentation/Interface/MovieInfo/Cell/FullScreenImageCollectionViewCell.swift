//
//  FullScreenImageCollectionViewCell.swift
//  Moony
//
//  Created by 서충원 on 7/15/24.
//

import UIKit

final class FullScreenImageCollectionViewCell: BaseCollectionViewCell {
    let posterImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    private lazy var gradientView = UIView().then {
        $0.backgroundColor = .clear
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(origin: .zero, size: CGSize(width: FullScreenImageCollectionViewCell.screenSize.width, height: 300))
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
    
    func configureCell(poster: Poster) {
        let url = URL(string: poster.posterUrl)
        posterImageView.kf.setImage(with: url)
    }
}

