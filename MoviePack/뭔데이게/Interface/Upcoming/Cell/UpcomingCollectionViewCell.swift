//
//  UpcomingCollectionViewCell.swift
//  MoviePack
//
//  Created by 서충원 on 8/10/24.
//

import UIKit
import VisualEffectView

final class UpcomingCollectionViewCell: BaseCollectionViewCell {
    
    private let releaseDateLabel = UILabel().then {
        $0.font = Fonts.stretch(27)
        $0.textColor = Colors.blackContent
    }
    
    private let upcomingImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
    }
    
    private let containerView = UIView().then {
        $0.backgroundColor = Colors.blackBackground.withAlphaComponent(0.3)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
    }
    
    private let containerVisualEffectView = VisualEffectView().then {
        $0.colorTint = Colors.blackBackground
        $0.colorTintAlpha = 0.2
        $0.blurRadius = 3
        $0.scale = 1
    }
    
    private let titleLabel = UILabel().then {
        $0.font = Fonts.han(20)
        $0.textColor = Colors.blackAccent
    }
    
    private let mainActorImageView = UIImageView().then {
        $0.backgroundColor = Colors.blackAccent
    }
    
    private let engTitleLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 18)
        $0.textColor = Colors.blackAccent.withAlphaComponent(0.5)
        $0.numberOfLines = 2
    }
    
    override func configureSubViews() {
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(upcomingImageView)
        contentView.addSubview(containerView)
        containerView.addSubview(containerVisualEffectView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(engTitleLabel)
    }
    
    override func configureConstraints() {
        releaseDateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(upcomingImageView.snp.top).offset(-12)
            make.leading.equalToSuperview().offset(6)
        }
        
        upcomingImageView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(upcomingImageView.snp.width)
        }
        
        containerVisualEffectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview().inset(16)
            make.height.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(20)
        }
        
//        engTitleLabel.snp.makeConstraints { make in
//            make.top.equalTo(titleLabel.snp.bottom).offset(4)
//            make.horizontalEdges.equalToSuperview().inset(22)
//        }
    }
    
    func configureCell(result: Movie) {
        releaseDateLabel.text = result.releaseDate
        let url = URL(string: result.imageUrl)
        upcomingImageView.kf.setImage(with: url)
        titleLabel.text = result.name
        engTitleLabel.text = result.originalName
    }
}
