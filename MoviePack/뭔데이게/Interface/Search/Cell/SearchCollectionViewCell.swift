//
//  SearchCollectionViewCell.swift
//  MoviePack
//
//  Created by 서충원 on 6/11/24.
//

import UIKit

class SearchCollectionViewCell: BaseCollectionViewCell {
    
    var gradientLayer: CAGradientLayer?
    
    let searchImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .heavy)
        $0.textAlignment = .center
        $0.textColor = Colors.blackAccent
        $0.numberOfLines = 2
    }
    
    override func configureSubViews() {
        contentView.addSubview(searchImageView)
        contentView.addSubview(titleLabel)
    }
    
    override func configureConstraints() {
        searchImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        removeGradient()
        addGradient()
    }
    
    func addGradient() {
        contentView.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = searchImageView.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, Colors.blackBackground.cgColor]
        searchImageView.layer.addSublayer(gradientLayer)
        
        // 새로 추가된 gradientLayer를 저장
        self.gradientLayer = gradientLayer
    }
    
    func removeGradient() {
        if let gradientLayer = self.gradientLayer {
            gradientLayer.removeFromSuperlayer()
            self.gradientLayer = nil
        }
    }
    
    func configureCell(result: Movie) {
        titleLabel.text = result.name
        let url = URL(string: result.imageUrl)
        searchImageView.kf.setImage(with: url)
    }
}

