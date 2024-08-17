//
//  UpcomingCollectionViewCell.swift
//  Moony
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
    
    private let expectationVisualEffectView = VisualEffectView().then {
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
        $0.colorTint = Colors.blackBackground
        $0.colorTintAlpha = 0.2
        $0.blurRadius = 3
        $0.scale = 1
    }
    
    private let expectationImage = UIImageView().then {
        let config = UIImage.SymbolConfiguration(weight: .black)
        $0.image = Images.heart?.withConfiguration(config)
        $0.contentMode = .scaleAspectFill
        $0.tintColor = Colors.blackAccent
    }
    
    private let expectationLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 15)
        $0.textColor = Colors.blackAccent
    }
    
    private let titleLabel = UILabel().then {
        $0.font = Fonts.han(20)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.numberOfLines = 2
    }
    
    private let engTitleLabel = UILabel().then {
        $0.font = Fonts.stretch(12)
        $0.textColor = Colors.blackDescription
        $0.textAlignment = .center
    }
    
    override func configureSubViews() {
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(backgroundImageView)
        backgroundImageView.addSubview(backgroundVisualEffectView)
        contentView.addSubview(posterImageView)
        contentView.addSubview(expectationVisualEffectView)
        contentView.addSubview(expectationImage)
        contentView.addSubview(expectationLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(engTitleLabel)
    }
    
    override func configureConstraints() {
        releaseDateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(backgroundImageView.snp.top).offset(-12)
            make.leading.equalToSuperview().offset(6)
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(backgroundImageView.snp.width).multipliedBy(1.2)
        }
        
        backgroundVisualEffectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        posterImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(backgroundImageView.snp.top).inset(20)
            make.height.equalTo(posterImageView.snp.width)
        }
        
        expectationVisualEffectView.snp.makeConstraints { make in
            make.top.leading.equalTo(posterImageView).inset(12)
            make.trailing.equalTo(expectationLabel).offset(10)
            make.height.equalTo(32)
        }
        
        expectationImage.snp.makeConstraints { make in
            make.leading.equalTo(expectationVisualEffectView).inset(10)
            make.centerY.equalTo(expectationVisualEffectView)
            make.size.equalTo(16)
        }
        
        expectationLabel.snp.makeConstraints { make in
            make.leading.equalTo(expectationImage.snp.trailing).offset(6)
            make.centerY.equalTo(expectationVisualEffectView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
        
        engTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    func configureCell(result: Movie) {
        releaseDateLabel.text = result.releaseDate
        ///Show Skeleton View
        posterImageView.showAnimatedGradientSkeleton()
        let url = URL(string: result.imageUrl)
        backgroundImageView.kf.setImage(with: url)
        posterImageView.kf.setImage(with: url) { [weak self] _ in
            ///Hide Skeleton View
            self?.posterImageView.stopSkeletonAnimation()
            self?.posterImageView.hideSkeleton()
        }
        expectationLabel.text = "\(result.popularity ?? 0.0)"
        titleLabel.text = result.name
        engTitleLabel.text = result.originalName
    }
}
