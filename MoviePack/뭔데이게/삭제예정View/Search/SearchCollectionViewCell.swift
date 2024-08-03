//
//  SearchCollectionViewCell.swift
//  MoviePack
//
//  Created by 서충원 on 6/11/24.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    var gradientLayer: CAGradientLayer?
    
    let searchImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .darkGray
        imageView.image = UIImage(named: "Movie")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .black)
        label.textAlignment = .center
        label.textColor = .white.withAlphaComponent(0.8)
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
        configureConstraints()
        addGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubviews() {
        contentView.addSubview(searchImageView)
        contentView.addSubview(titleLabel)
    }
    
    func configureConstraints() {
        searchImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
        }
    }
    
    func addGradient() {
        contentView.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = searchImageView.bounds
        let colors: [CGColor] = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.9).cgColor]
        gradientLayer.colors = colors
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

