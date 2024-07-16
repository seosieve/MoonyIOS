//
//  TrendCollectionViewCell.swift
//  MoviePack
//
//  Created by 서충원 on 7/13/24.
//

import UIKit
import Then
import SnapKit
import Kingfisher

final class TrendCollectionViewCell: BaseCollectionViewCell {
    
    private let trendImageView = UIImageView().then {
        $0.backgroundColor = Colors.blackAccent
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 15)
        $0.textColor = Colors.blackDescription
    }

    private let engTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = Colors.blackContent
        $0.numberOfLines = 2
    }
    
    override func configureView() {
        contentView.backgroundColor = Colors.blackBackground
    }
    
    override func configureSubViews() {
        contentView.addSubview(trendImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(engTitleLabel)
    }
    
    override func configureConstraints() {
        trendImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(180)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(trendImageView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(2)
        }
        
        engTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(2)
        }
    }
    
    func configureCell(_ trend: Movie) {
        let url = URL(string: trend.imageUrl)
        trendImageView.kf.setImage(with: url)
        
        titleLabel.text = trend.title
        engTitleLabel.text = trend.originalTitle
    }
    
    func configureCell(_ trend: Person) {
        let url = URL(string: trend.imageUrl)
        trendImageView.kf.setImage(with: url)
        
        titleLabel.text = trend.name
        engTitleLabel.text = trend.originalName
    }
    
    func configureCell(_ trend: TV) {
        let url = URL(string: trend.imageUrl)
        trendImageView.kf.setImage(with: url)
        
        titleLabel.text = trend.name
        engTitleLabel.text = trend.originalName
    }
}
