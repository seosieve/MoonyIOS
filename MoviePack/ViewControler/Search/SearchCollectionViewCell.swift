//
//  SearchCollectionViewCell.swift
//  MoviePack
//
//  Created by 서충원 on 6/11/24.
//

import UIKit
import SnapKit

class SearchCollectionViewCell: UICollectionViewCell, Configure {
    
    let searchImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray4
        imageView.image = UIImage(named: "Movie")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .black)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        configureSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews() {
        
    }
    
    func configureSubviews() {
        contentView.addSubview(searchImageView)
        searchImageView.addSubview(titleLabel)
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
}

